#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int number_of_ways(int target, int** types, int typesSize, int* typesColSize) {
    int dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < typesSize; i++) {
        int count = types[i][0];
        int point = types[i][1];

        for (int j = 1; j <= count; j++) {
            for (int k = target; k >= point; k--) {
                dp[k] = (dp[k] + dp[k - point]) % 1000000007;
            }
        }
    }

    return dp[target];
}