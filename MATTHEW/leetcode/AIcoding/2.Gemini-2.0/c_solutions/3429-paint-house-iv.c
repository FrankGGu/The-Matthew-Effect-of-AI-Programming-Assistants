#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* costs, int costsSize, int costsColSize, int n, int k, int target) {
    int dp[n + 1][target + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= target; j++) {
            dp[i][j] = INT_MAX;
        }
    }
    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= target; j++) {
            for (int l = 0; l < k; l++) {
                if (j >= 1) {
                    int prev_count = j - 1;
                    if (j == 1) prev_count = 0;
                     for (int prev = 0; prev < i; prev++){
                        int cost = costs[(i-1) * costsColSize + l];
                        if (prev_count >= 0 && dp[i-1][prev_count] != INT_MAX) {
                            int prev_color = -1;
                            if(i > 1){

                                for(int m = 0; m < k; m++){
                                    if(dp[i-1][prev_count] - costs[(i-2) * costsColSize + m] >= 0 && dp[i-1][prev_count] - costs[(i-2) * costsColSize + m] < costs[(i-1) * costsColSize + l] ){
                                        prev_color = m;
                                        break;
                                    }
                                }

                            }
                            if(prev_color == l && i > 1){
                                continue;
                            }
                            int temp = dp[i-1][prev_count];
                            if(prev_count > 0){
                                for(int m = 0; m < k; m++){
                                    if(dp[i-1][prev_count] - costs[(i-2) * costsColSize + m] >= 0 && dp[i-1][prev_count] - costs[(i-2) * costsColSize + m] < costs[(i-1) * costsColSize + l] ){
                                        temp = dp[i-1][prev_count] - costs[(i-2) * costsColSize + m];
                                        break;
                                    }
                                }
                            }

                            dp[i][j] = (dp[i][j] > temp + cost) ? temp + cost : dp[i][j];
                        }
                    }

                   if(i == 1 && j == 1){
                        dp[i][j] = costs[(i-1) * costsColSize + l];
                    }
                }
            }
        }
    }

    if (dp[n][target] == INT_MAX) {
        return -1;
    }
    return dp[n][target];
}