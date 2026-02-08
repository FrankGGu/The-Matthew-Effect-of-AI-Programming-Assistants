#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

bool canDistribute(int* nums, int numsSize, int* quantity, int quantitySize) {
    int freq[51] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }
    int unique_freq[numsSize + 1];
    int unique_count = 0;
    for (int i = 0; i < 51; i++) {
        if (freq[i] > 0) {
            unique_freq[unique_count++] = freq[i];
        }
    }

    qsort(unique_freq, unique_count, sizeof(int), cmp);
    qsort(quantity, quantitySize, sizeof(int), cmp);

    int dp[1 << quantitySize];
    for (int i = 0; i < (1 << quantitySize); i++) {
        dp[i] = 0;
    }

    dp[0] = 1;

    for (int i = 0; i < unique_count; i++) {
        for (int mask = (1 << quantitySize) - 1; mask >= 0; mask--) {
            if (dp[mask]) {
                for (int submask = 1; submask < (1 << quantitySize); submask++) {
                    if ((mask & submask) == 0) {
                        int sum = 0;
                        for (int j = 0; j < quantitySize; j++) {
                            if ((submask >> j) & 1) {
                                sum += quantity[j];
                            }
                        }
                        if (sum <= unique_freq[i]) {
                            dp[mask | submask] = 1;
                        }
                    }
                }
            }
        }
    }

    return dp[(1 << quantitySize) - 1];
}