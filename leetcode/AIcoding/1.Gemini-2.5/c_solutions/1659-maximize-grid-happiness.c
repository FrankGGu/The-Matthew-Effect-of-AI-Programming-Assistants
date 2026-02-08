#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INTROVERT_BASE_HAPPINESS 120
#define EXTROVERT_BASE_HAPPINESS 40

#define INTROVERT_INTROVERT_INTERACTION -60 // -30 for each
#define EXTROVERT_EXTROVERT_INTERACTION 40  // +20 for each
#define INTROVERT_EXTROVERT_INTERACTION -20 // -10 for each

enum PersonType {
    EMPTY = 0,
    INTROVERT = 1,
    EXTROVERT = 2
};

int M, N;
int total_cells;
int powersOf3[6]; // powersOf3[i] = 3^i, max N is 5, so powersOf3[5] is the largest needed

int dp[26][7][7][244]; // M*N <= 25, introvertsCount <= 6, extrovertsCount <= 6, 3^5 = 243

int get_digit(int mask, int j) {
    return (mask / powersOf3[j]) % 3;
}

int int_max(int a, int b) {
    return a > b ? a : b;
}

int calculate_happiness(int r, int c, int person_type, int mask) {
    int happiness = 0;

    // Base happiness for the person placed
    if (person_type == INTROVERT) {
        happiness += INTROVERT_BASE_HAPPINESS;
    } else if (person_type == EXTROVERT) {
        happiness += EXTROVERT_BASE_HAPPINESS;
    } else { // EMPTY
        return 0; // No happiness from placing an empty cell
    }

    // Interaction with 'up' neighbor (r-1, c)
    if (r > 0) { // Only if not in the first row
        int up_state = get_digit(mask, c);
        if (up_state != EMPTY) {
            if (person_type == INTROVERT) {
                if (up_state == INTROVERT) happiness += INTROVERT_INTROVERT_INTERACTION;
                else if (up_state == EXTROVERT) happiness += INTROVERT_EXTROVERT_INTERACTION;
            } else { // person_type == EXTROVERT
                if (up_state == INTROVERT) happiness += INTROVERT_EXTROVERT_INTERACTION;
                else if (up_state == EXTROVERT) happiness += EXTROVERT_EXTROVERT_INTERACTION;
            }
        }
    }

    // Interaction with 'left' neighbor (r, c-1)
    if (c > 0) { // Only if not in the first column
        int left_state = get_digit(mask, c - 1);
        if (left_state != EMPTY) {
            if (person_type == INTROVERT) {
                if (left_state == INTROVERT) happiness += INTROVERT_INTROVERT_INTERACTION;
                else if (left_state == EXTROVERT) happiness += INTROVERT_EXTROVERT_INTERACTION;
            } else { // person_type == EXTROVERT
                if (left_state == INTROVERT) happiness += INTROVERT_EXTROVERT_INTERACTION;
                else if (left_state == EXTROVERT) happiness += EXTROVERT_EXTROVERT_INTERACTION;
            }
        }
    }

    return happiness;
}

int maximizeGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
    M = m;
    N = n;
    total_cells = M * N;

    // Precompute powers of 3
    powersOf3[0] = 1;
    for (int i = 1; i <= N; ++i) {
        powersOf3[i] = powersOf3[i-1] * 3;
    }

    // Initialize DP table with -1 (unreachable state). Happiness can be negative.
    for (int i = 0; i <= total_cells; ++i) {
        for (int j = 0; j <= introvertsCount; ++j) {
            for (int k = 0; k <= extrovertsCount; ++k) {
                for (int l = 0; l < powersOf3[N]; ++l) {
                    dp[i][j][k][l] = -1;
                }
            }
        }
    }

    // Base case: Before processing any cell, 0 happiness, all counts available, empty mask
    dp[0][introvertsCount][extrovertsCount][0] = 0;

    int current_max_happiness = 0; // Initialize with 0, as placing no one results in 0 happiness

    // Iterate through each cell linearly (k = r*N + c)
    for (int k = 0; k < total_cells; ++k) {
        int r = k / N;
        int c = k % N;

        for (int i = 0; i <= introvertsCount; ++i) {
            for (int e = 0; e <= extrovertsCount; ++e) {
                for (int mask = 0; mask < powersOf3[N]; ++mask) {
                    if (dp[k][i][e][mask] == -1) {
                        continue; // Skip unreachable states
                    }

                    // Option 1: Place nothing (EMPTY) at (r, c)
                    int current_happiness_empty = calculate_happiness(r, c, EMPTY, mask);
                    // Update the c-th digit of the mask to EMPTY (0)
                    int next_mask_empty = mask - (get_digit(mask, c) * powersOf3[c]);
                    dp[k+1][i][e][next_mask_empty] =
                        int_max(dp[k+1][i][e][next_mask_empty], dp[k][i][e][mask] + current_happiness_empty);

                    // Option 2: Place an INTROVERT at (r, c)
                    if (i > 0) {
                        int current_happiness_introvert = calculate_happiness(r, c, INTROVERT, mask);
                        // Update the c-th digit of the mask to INTROVERT (1)
                        int next_mask_introvert = mask - (get_digit(mask, c) * powersOf3[c]) + (INTROVERT * powersOf3[c]);
                        dp[k+1][i-1][e][next_mask_introvert] =
                            int_max(dp[k+1][i-1][e][next_mask_introvert], dp[k][i][e][mask] + current_happiness_introvert);
                    }

                    // Option 3: Place an EXTROVERT at (r, c)
                    if (e > 0) {
                        int current_happiness_extrovert = calculate_happiness(r, c, EXTROVERT, mask);
                        // Update the c-th digit of the mask to EXTROVERT (2)
                        int next_mask_extrovert = mask - (get_digit(mask, c) * powersOf3[c]) + (EXTROVERT * powersOf3[c]);
                        dp[k+1][i][e-1][next_mask_extrovert] =
                            int_max(dp[k+1][i][e-1][next_mask_extrovert], dp[k][i][e][mask] + current_happiness_extrovert);
                    }
                }
            }
        }
    }

    // After filling all cells, find the maximum happiness from any reachable state at dp[total_cells]
    for (int i = 0; i <= introvertsCount; ++i) {
        for (int e = 0; e <= extrovertsCount; ++e) {
            for (int mask = 0; mask < powersOf3[N]; ++mask) {
                if (dp[total_cells][i][e][mask] != -1) {
                    current_max_happiness = int_max(current_max_happiness, dp[total_cells][i][e][mask]);
                }
            }
        }
    }

    return current_max_happiness;
}