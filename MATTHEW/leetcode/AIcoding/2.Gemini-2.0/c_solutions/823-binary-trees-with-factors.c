#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int numFactoredBinaryTrees(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), cmp);
    long long dp[arrSize];
    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
    }

    for (int i = 1; i < arrSize; i++) {
        for (int j = 0; j < i; j++) {
            if (arr[i] % arr[j] == 0) {
                int k;
                for (k = 0; k < arrSize; k++) {
                    if (arr[k] == arr[i] / arr[j]) {
                        dp[i] = (dp[i] + dp[j] * dp[k]) % MOD;
                        if (arr[j] != arr[k]) {
                            dp[i] = (dp[i] + dp[j] * dp[k]) % MOD;
                        }
                        break;
                    }
                }
            }
        }
    }

    long long ans = 0;
    for (int i = 0; i < arrSize; i++) {
        ans = (ans + dp[i]) % MOD;
    }

    return (int)ans;
}