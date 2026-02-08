#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestNumber(int* cost, int costSize) {
    int i, j;
    char** dp = (char**)malloc(sizeof(char*) * (costSize + 1));
    for (i = 0; i <= costSize; i++) {
        dp[i] = (char*)malloc(sizeof(char) * (costSize + 2));
        dp[i][0] = '\0';
    }

    for (i = 1; i <= costSize; i++) {
        for (j = 1; j <= costSize; j++) {
            if (cost[j - 1] <= i) {
                char* temp = (char*)malloc(sizeof(char) * (strlen(dp[i - cost[j - 1]]) + 2));
                sprintf(temp, "%d%s", j, dp[i - cost[j - 1]]);
                if (strlen(temp) > strlen(dp[i])) {
                    strcpy(dp[i], temp);
                }
                free(temp);
            }
        }
    }

    if (strlen(dp[costSize]) == 0) {
        return "0";
    }

    char* result = (char*)malloc(sizeof(char) * (strlen(dp[costSize]) + 1));
    strcpy(result, dp[costSize]);
    for (i = 0; i < strlen(result); i++) {
        result[i] = result[i] + '0';
    }
    result[strlen(result)] = '\0';

    for (i = 0; i <= costSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}