#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestNumber(int cost[], int costSize, int target) {
    char** dp = (char**)malloc((target + 1) * sizeof(char*));
    for (int i = 0; i <= target; i++) {
        dp[i] = NULL;
    }
    dp[0] = strdup("");

    for (int i = 1; i <= 9; i++) {
        for (int j = cost[i - 1]; j <= target; j++) {
            if (dp[j - cost[i - 1]] != NULL) {
                char* temp = (char*)malloc((strlen(dp[j - cost[i - 1]]) + 2) * sizeof(char));
                sprintf(temp, "%s%d", dp[j - cost[i - 1]], i);

                int len1 = (dp[j] == NULL) ? 0 : strlen(dp[j]);
                int len2 = strlen(temp);

                if (dp[j] == NULL || len2 > len1 || (len2 == len1 && strcmp(temp, dp[j]) > 0)) {
                    if (dp[j] != NULL) {
                        free(dp[j]);
                    }
                    dp[j] = temp;
                } else {
                    free(temp);
                }
            }
        }
    }

    char* result = dp[target];
    if (result == NULL || strlen(result) == 0) {
        return strdup("0");
    }

    for (int i = 0; i <= target; i++) {
        if (i != target && dp[i] != NULL) {
            free(dp[i]);
        }
    }
    free(dp);

    return result;
}