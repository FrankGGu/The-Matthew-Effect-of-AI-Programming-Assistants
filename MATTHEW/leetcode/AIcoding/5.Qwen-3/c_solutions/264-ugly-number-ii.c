#include <stdio.h>
#include <stdlib.h>

int nthUglyNumber(int n) {
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = 1;
    int i2 = 0, i3 = 0, i5 = 0;
    for (int i = 1; i < n; i++) {
        int next2 = dp[i2] * 2;
        int next3 = dp[i3] * 3;
        int next5 = dp[i5] * 5;
        int min_val = fmin(fmin(next2, next3), next5);
        dp[i] = min_val;
        if (min_val == next2) i2++;
        if (min_val == next3) i3++;
        if (min_val == next5) i5++;
    }
    int result = dp[n - 1];
    free(dp);
    return result;
}