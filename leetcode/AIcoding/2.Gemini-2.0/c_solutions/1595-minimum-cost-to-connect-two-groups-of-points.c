#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCostConnectTwoGroups(int** cost, int costSize, int* costColSize,
                             int group1Size, int group2Size) {
  int dp[group1Size + 1][1 << group2Size];
  for (int i = 0; i <= group1Size; i++) {
    for (int j = 0; j < (1 << group2Size); j++) {
      dp[i][j] = INT_MAX;
    }
  }
  dp[0][0] = 0;

  for (int i = 1; i <= group1Size; i++) {
    for (int j = 0; j < (1 << group2Size); j++) {
      for (int k = 0; k < group2Size; k++) {
        if (dp[i - 1][j] != INT_MAX) {
          dp[i][j | (1 << k)] =
              fmin(dp[i][j | (1 << k)], dp[i - 1][j] + cost[i - 1][k]);
        }
        if ((j & (1 << k)) && dp[i - 1][j] != INT_MAX) {
          dp[i][j] = fmin(dp[i][j], dp[i - 1][j]);
        }
      }
      for (int prev_j = 0; prev_j < (1 << group2Size); prev_j++) {
        if (dp[i - 1][prev_j] != INT_MAX) {
          int temp = INT_MAX;
          for (int k = 0; k < group2Size; k++) {
            temp = fmin(temp, cost[i - 1][k]);
          }
          dp[i][j] = fmin(dp[i][j], dp[i - 1][prev_j] + temp);
        }
      }

      for (int k = 0; k < group2Size; k++) {
        if (dp[i - 1][j] != INT_MAX) {
          dp[i][j] = fmin(dp[i][j], dp[i - 1][j]);
        }
      }
    }
  }

  int min_cost = dp[group1Size][(1 << group2Size) - 1];
  if (min_cost == INT_MAX) {
    min_cost = 0;
    for (int i = 0; i < group1Size; i++) {
      int temp = INT_MAX;
      for (int k = 0; k < group2Size; k++) {
        temp = fmin(temp, cost[i][k]);
      }
      min_cost += temp;
    }
  }

  return min_cost;
}