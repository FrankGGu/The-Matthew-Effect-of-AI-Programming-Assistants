#include <stdlib.h> // For qsort

int compareLongLong(const void *a, const void *b) {
    long long valA = *(long long*)a;
    long long valB = *(long long*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

int sumDistance(int* positions, int positionsSize, char* directions, int d) {
    long long MOD = 1000000007;
    int n = positionsSize;

    // Allocate memory for the final positions of robots
    long long* final_pos = (long long*)malloc(n * sizeof(long long));
    // It's good practice to check for malloc failure, though LeetCode usually guarantees success
    if (final_pos == NULL) {
        return -1; // Or handle error appropriately
    }

    // Calculate the final position for each robot
    for (int i = 0; i < n; i++) {
        if (directions[i] == 'L') {
            final_pos[i] = (long long)positions[i] - d;
        } else { // directions[i] == 'R'
            final_pos[i] = (long long)positions[i] + d;
        }
    }

    // Sort the final positions to easily calculate the sum of absolute differences
    qsort(final_pos, n, sizeof(long long), compareLongLong);

    // Calculate the sum of absolute differences between all pairs of final positions
    // The sum of |p_j - p_i| for i < j in a sorted array p is sum(p_k * (2k - (n-1)))
    long long total_sum = 0;
    for (int k = 0; k < n; k++) {
        long long pk_val = final_pos[k];
        long long coeff = (2LL * k - (n - 1));

        // Apply modulo arithmetic, ensuring intermediate results are positive
        // (val % MOD + MOD) % MOD handles negative values correctly in C
        long long term_mod = (pk_val % MOD + MOD) % MOD;
        long long coeff_mod = (coeff % MOD + MOD) % MOD;

        total_sum = (total_sum + (term_mod * coeff_mod) % MOD) % MOD;
    }

    // Free the allocated memory
    free(final_pos);

    // The problem asks for an int return type, so cast the long long sum
    return (int)total_sum;
}