#include <stdlib.h>

int* productQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int powers[30]; // Maximum 30 powers of 2 for n up to 10^9 (2^29 < 10^9 < 2^30)
    int count = 0;
    long long current_power_of_2 = 1;

    for (int i = 0; i < 30; ++i) {
        if ((n >> i) & 1) { // If the i-th bit of n is set
            powers[count++] = (int)current_power_of_2;
        }
        current_power_of_2 *= 2;
    }

    int MOD = 1000000007;
    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int q = 0; q < queriesSize; ++q) {
        int left = queries[q][0];
        int right = queries[q][1];
        long long current_product = 1;

        for (int i = left; i <= right; ++i) {
            current_product = (current_product * powers[i]) % MOD;
        }
        results[q] = (int)current_product;
    }

    return results;
}