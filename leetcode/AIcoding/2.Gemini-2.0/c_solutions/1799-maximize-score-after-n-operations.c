#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int solve(int mask, int op, int* nums, int numsSize, int* memo) {
    if (op > numsSize / 2) {
        return 0;
    }

    if (memo[mask] != -1) {
        return memo[mask];
    }

    int max_score = 0;
    for (int i = 0; i < numsSize; i++) {
        if ((mask & (1 << i)) == 0) {
            for (int j = i + 1; j < numsSize; j++) {
                if ((mask & (1 << j)) == 0) {
                    int new_mask = mask | (1 << i) | (1 << j);
                    int current_score = op * gcd(nums[i], nums[j]) + solve(new_mask, op + 1, nums, numsSize, memo);
                    if (current_score > max_score) {
                        max_score = current_score;
                    }
                }
            }
        }
    }

    memo[mask] = max_score;
    return max_score;
}

int maxScore(int* nums, int numsSize) {
    int* memo = (int*)malloc(sizeof(int) * (1 << numsSize));
    for (int i = 0; i < (1 << numsSize); i++) {
        memo[i] = -1;
    }

    int result = solve(0, 1, nums, numsSize, memo);
    free(memo);
    return result;
}