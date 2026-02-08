#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long solve(int** questions, int questionsSize, int* questionsColSize) {
    long long dp[questionsSize + 1];
    for (int i = 0; i <= questionsSize; i++) {
        dp[i] = 0;
    }

    for (int i = questionsSize - 1; i >= 0; i--) {
        dp[i] = questions[i][0];
        if (i + questions[i][1] + 1 < questionsSize) {
            dp[i] += dp[i + questions[i][1] + 1];
        }
        dp[i] = max(dp[i], dp[i + 1]);
    }

    return dp[0];
}