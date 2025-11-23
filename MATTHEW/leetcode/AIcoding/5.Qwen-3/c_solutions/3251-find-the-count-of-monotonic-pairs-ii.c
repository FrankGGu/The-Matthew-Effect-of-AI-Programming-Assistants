#include <stdio.h>
#include <stdlib.h>

long long countMonotonicPairs(int n, int* a) {
    long long dp[100001] = {0};
    for (int i = 0; i < n; i++) {
        dp[a[i]] += 1;
        for (int j = 1; j <= a[i]; j++) {
            dp[a[i]] += dp[j];
        }
    }
    long long result = 0;
    for (int i = 1; i <= 100000; i++) {
        result += dp[i];
    }
    return result;
}