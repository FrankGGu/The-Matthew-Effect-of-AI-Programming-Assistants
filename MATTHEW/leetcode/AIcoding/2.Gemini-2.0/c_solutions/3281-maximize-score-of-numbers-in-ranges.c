#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 1005
#define MAXM 2005

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximizeTheScore(int nums[], int numsSize, int quantity[], int quantitySize) {
    int n = numsSize;
    int m = quantitySize;

    int totalQuantity = 0;
    for (int i = 0; i < m; i++) {
        totalQuantity += quantity[i];
    }

    int dp[totalQuantity + 1];
    memset(dp, 0, sizeof(dp));

    qsort(nums, n, sizeof(int), compare);

    for (int i = 0; i < m; i++) {
        for (int j = totalQuantity; j >= quantity[i]; j--) {
            dp[j] = max(dp[j], dp[j - quantity[i]] + nums[n - 1 - i] * quantity[i]);
        }
    }

    return dp[totalQuantity];
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}