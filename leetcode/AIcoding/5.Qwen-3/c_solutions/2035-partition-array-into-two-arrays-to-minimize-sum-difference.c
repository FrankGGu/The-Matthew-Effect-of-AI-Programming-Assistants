#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int solve(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int target = total / 2;
    int n = numsSize;

    int* dp = (int*)malloc((target + 1) * sizeof(int));
    for (int i = 0; i <= target; i++) {
        dp[i] = INT_MIN;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        int val = nums[i];
        for (int j = target; j >= val; j--) {
            if (dp[j - val] != INT_MIN) {
                dp[j] = max(dp[j], dp[j - val] + val);
            }
        }
    }

    int closest = 0;
    for (int i = 0; i <= target; i++) {
        if (dp[i] != INT_MIN) {
            closest = max(closest, dp[i]);
        }
    }

    return abs(total - 2 * closest);
}

int main() {
    return 0;
}