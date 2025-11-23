#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int *houses, int housesSize, int *cost, int costSize, int m, int n,
            int target) {
  int dp[m + 1][target + 1][n + 1];
  for (int i = 0; i <= m; i++) {
    for (int j = 0; j <= target; j++) {
      for (int k = 0; k <= n; k++) {
        dp[i][j][k] = INT_MAX / 2;
      }
    }
  }

  for (int i = 1; i <= n; i++) {
    if (houses[0] == 0) {
      dp[1][1][i] = cost[0 * n + (i - 1)];
    } else if (houses[0] == i) {
      dp[1][1][i] = 0;
    }
  }

  for (int i = 2; i <= m; i++) {
    for (int j = 1; j <= target; j++) {
      for (int k = 1; k <= n; k++) {
        if (houses[i - 1] != 0 && houses[i - 1] != k) {
          continue;
        }
        int curCost = (houses[i - 1] == 0) ? cost[(i - 1) * n + (k - 1)] : 0;
        for (int l = 1; l <= n; l++) {
          if (k == l) {
            if (j >= 1 && dp[i - 1][j][l] != INT_MAX / 2) {
              dp[i][j][k] =
                  fmin(dp[i][j][k], dp[i - 1][j][l] + curCost);
            }
          } else {
            if (j > 1 && dp[i - 1][j - 1][l] != INT_MAX / 2) {
              dp[i][j][k] =
                  fmin(dp[i][j][k], dp[i - 1][j - 1][l] + curCost);
            }
          }
        }
      }
    }
  }

  int res = INT_MAX / 2;
  for (int i = 1; i <= n; i++) {
    res = fmin(res, dp[m][target][i]);
  }

  return (res == INT_MAX / 2) ? -1 : res;
}