#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int* pathsWithMaxScore(char** board, int boardSize, int* boardColSize, int* returnSize) {
    int n = boardSize;
    int dp[n][n][2];
    memset(dp, 0, sizeof(dp));

    dp[n - 1][n - 1][0] = 0;
    dp[n - 1][n - 1][1] = 1;

    for (int i = n - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            if (board[i][j] == 'X') {
                dp[i][j][0] = 0;
                dp[i][j][1] = 0;
                continue;
            }

            if (i == n - 1 && j == n - 1) continue;

            int max_score = -1;
            long long paths = 0;

            if (i + 1 < n) {
                if (dp[i + 1][j][0] != -1) {
                    if (dp[i + 1][j][0] > max_score) {
                        max_score = dp[i + 1][j][0];
                        paths = dp[i + 1][j][1];
                    } else if (dp[i + 1][j][0] == max_score) {
                        paths = (paths + dp[i + 1][j][1]) % MOD;
                    }
                }
            }

            if (j + 1 < n) {
                if (dp[i][j + 1][0] != -1) {
                    if (dp[i][j + 1][0] > max_score) {
                        max_score = dp[i][j + 1][0];
                        paths = dp[i][j + 1][1];
                    } else if (dp[i][j + 1][0] == max_score) {
                        paths = (paths + dp[i][j + 1][1]) % MOD;
                    }
                }
            }

            if (i + 1 < n && j + 1 < n) {
                if (dp[i + 1][j + 1][0] != -1) {
                    if (dp[i + 1][j + 1][0] > max_score) {
                        max_score = dp[i + 1][j + 1][0];
                        paths = dp[i + 1][j + 1][1];
                    } else if (dp[i + 1][j + 1][0] == max_score) {
                        paths = (paths + dp[i + 1][j + 1][1]) % MOD;
                    }
                }
            }

            if (max_score == -1) {
                dp[i][j][0] = -1;
                dp[i][j][1] = 0;
            } else {
                dp[i][j][0] = max_score + (board[i][j] == 'S' ? 0 : (board[i][j] - '0'));
                dp[i][j][1] = (int)paths;
            }
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    if (dp[0][0][0] == -1) {
        result[0] = 0;
        result[1] = 0;
    } else {
        result[0] = dp[0][0][0];
        result[1] = dp[0][0][1];
    }

    return result;
}