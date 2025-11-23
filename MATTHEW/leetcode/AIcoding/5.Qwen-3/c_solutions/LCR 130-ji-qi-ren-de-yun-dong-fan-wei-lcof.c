#include <stdio.h>
#include <stdlib.h>

int arrangeClosets(int* closet, int closetSize) {
    int* dp = (int*)malloc((closetSize + 1) * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i <= closetSize; i++) {
        dp[i] = dp[i - 1] + closet[i - 1];
        for (int j = 1; j < i; j++) {
            dp[i] = (dp[i] < dp[j] + closet[i - 1]) ? dp[i] : dp[j] + closet[i - 1];
        }
    }
    int result = dp[closetSize];
    free(dp);
    return result;
}