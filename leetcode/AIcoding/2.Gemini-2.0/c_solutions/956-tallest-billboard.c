#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tallestBillboard(int* rods, int rodsSize){
    int sum = 0;
    for (int i = 0; i < rodsSize; i++) {
        sum += rods[i];
    }

    int* dp = (int*)malloc((sum + 1) * sizeof(int));
    for (int i = 0; i <= sum; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < rodsSize; i++) {
        int* temp = (int*)malloc((sum + 1) * sizeof(int));
        memcpy(temp, dp, (sum + 1) * sizeof(int));

        for (int j = 0; j <= sum; j++) {
            if (temp[j] != -1) {
                int rod = rods[i];

                dp[j + rod] = (dp[j + rod] > temp[j]) ? dp[j + rod] : temp[j];

                int diff = abs(j - rod);
                dp[diff] = (dp[diff] > temp[j] + ((j > rod) ? rod : j)) ? dp[diff] : temp[j] + ((j > rod) ? rod : j);
            }
        }
        free(temp);
    }

    int result = dp[0];
    free(dp);
    return result;
}