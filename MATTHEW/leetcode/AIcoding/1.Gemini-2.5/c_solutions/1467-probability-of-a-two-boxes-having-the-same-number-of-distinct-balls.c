#include <stdlib.h>
#include <string.h>

#define MAX_N_TOTAL 48
#define MAX_BALLS_PER_BOX (MAX_N_TOTAL / 2)
#define MAX_COLORS 8

long long C[MAX_N_TOTAL + 1][MAX_N_TOTAL + 1];
long long memo[MAX_COLORS + 1][MAX_BALLS_PER_BOX + 1][MAX_COLORS + 1][MAX_COLORS + 1];

int B_balls[MAX_COLORS];
int N_COLORS_GLOBAL;
int TARGET_BALLS_PER_BOX_GLOBAL;

void precompute_combinations() {
    for (int i = 0; i <= MAX_N_TOTAL; ++i) {
        C[i][0] = 1;
        for (int j = 1; j <= i; ++j) {
            C[i][j] = C[i - 1][j - 1] + C[i - 1][j];
        }
    }
}

long long calculate_ways(int color_idx, int balls_box1, int distinct_box1, int distinct_box2) {
    if (color_idx == N_COLORS_GLOBAL) {
        if (balls_box1 == TARGET_BALLS_PER_BOX_GLOBAL && distinct_box1 == distinct_box2) {
            return 1;
        } else {
            return 0;
        }
    }

    if (memo[color_idx][balls_box1][distinct_box1][distinct_box2] != -1) {
        return memo[color_idx][balls_box1][distinct_box1][distinct_box2];
    }

    long long ans = 0;
    int current_color_balls = B_balls[color_idx];

    for (int k = 0; k <= current_color_balls; ++k) {
        int balls_for_box2 = current_color_balls - k;

        if (balls_box1 + k > TARGET_BALLS_PER_BOX_GLOBAL) {
            continue;
        }

        int new_distinct_box1 = distinct_box1;
        if (k > 0) {
            new_distinct_box1++;
        }

        int new_distinct_box2 = distinct_box2;
        if (balls_for_box2 > 0) {
            new_distinct_box2++;
        }

        long long ways_to_choose_current_color = C[current_color_balls][k];

        ans += ways_to_choose_current_color * calculate_ways(color_idx + 1,
                                                             balls_box1 + k,
                                                             new_distinct_box1,
                                                             new_distinct_box2);
    }

    return memo[color_idx][balls_box1][distinct_box1][distinct_box2] = ans;
}

double probabilityOfTwoBoxes(int* balls, int ballsSize) {
    N_COLORS_GLOBAL = ballsSize;
    int N_total = 0;
    for (int i = 0; i < ballsSize; ++i) {
        B_balls[i] = balls[i];
        N_total += balls[i];
    }

    if (N_total % 2 != 0) {
        return 0.0;
    }

    TARGET_BALLS_PER_BOX_GLOBAL = N_total / 2;

    precompute_combinations();

    for (int i = 0; i <= N_COLORS_GLOBAL; ++i) {
        for (int j = 0; j <= TARGET_BALLS_PER_BOX_GLOBAL; ++j) {
            for (int k = 0; k <= N_COLORS_GLOBAL; ++k) {
                for (int l = 0; l <= N_COLORS_GLOBAL; ++l) {
                    memo[i][j][k][l] = -1;
                }
            }
        }
    }

    long long numerator = calculate_ways(0, 0, 0, 0);
    long long denominator = C[N_total][TARGET_BALLS_PER_BOX_GLOBAL];

    return (double)numerator / denominator;
}