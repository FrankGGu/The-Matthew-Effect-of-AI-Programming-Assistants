#include <stdio.h>
#include <stdlib.h>

int* new21Game(int, int*, int, int);

int* new21Game(int N, int* K, int KSize, int maxPts) {
    int* dp = (int*)malloc(sizeof(int) * (N + 1));
    for (int i = 0; i <= N; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;
    int windowSum = 1;
    for (int i = 1; i <= N; i++) {
        if (i - maxPts >= 0) {
            windowSum -= dp[i - maxPts - 1];
        }
        if (i - 1 >= 0 && i - 1 < KSize) {
            windowSum += dp[i - 1];
        }
        dp[i] = windowSum;
    }
    int* result = (int*)malloc(sizeof(int) * 1);
    result[0] = dp[N];
    return result;
}