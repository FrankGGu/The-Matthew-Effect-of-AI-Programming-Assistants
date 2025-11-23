#include <stdio.h>
#include <stdlib.h>

int superEggDrop(int k, int n) {
    int* dp = (int*)malloc((k + 1) * sizeof(int));
    int m = 0;
    while (dp[k] < n) {
        for (int i = k; i > 0; i--) {
            dp[i] += dp[i - 1] + 1;
        }
        m++;
    }
    free(dp);
    return m;
}