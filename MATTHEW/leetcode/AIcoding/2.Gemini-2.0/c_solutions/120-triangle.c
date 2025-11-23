#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTotal(int** triangle, int triangleSize, int* triangleColSize){
    int *dp = (int*)malloc(sizeof(int) * (triangleSize + 1));
    for(int i = 0; i <= triangleSize; i++){
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for(int i = 0; i < triangleSize; i++){
        for(int j = triangleColSize[i] - 1; j >= 0; j--){
            if(dp[j] == INT_MAX && dp[j+1] == INT_MAX){
                dp[j] = triangle[i][j];
            } else if (dp[j] == INT_MAX){
                dp[j] = dp[j+1] + triangle[i][j];
            }
            else if (dp[j+1] == INT_MAX){
                dp[j] = dp[j] + triangle[i][j];
            }
            else{
                dp[j] = (dp[j] < dp[j+1] ? dp[j] : dp[j+1]) + triangle[i][j];
            }
        }
        for(int k = triangleColSize[i]; k <= triangleSize; k++){
            dp[k] = INT_MAX;
        }
    }

    int minTotal = INT_MAX;
    for(int i = 0; i < triangleColSize[triangleSize-1]; i++){
        if(dp[i] < minTotal){
            minTotal = dp[i];
        }
    }

    free(dp);
    return minTotal;
}