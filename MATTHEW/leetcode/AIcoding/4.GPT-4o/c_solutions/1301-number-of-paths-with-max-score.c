#include <stdio.h>
#include <stdlib.h>

#define MOD 1000000007

typedef struct {
    long long score;
    long long paths;
} Cell;

Cell maxScorePaths(int** board, int boardSize, int* boardColSize) {
    int m = boardSize, n = boardColSize[0];
    Cell** dp = (Cell**)malloc(m * sizeof(Cell*));
    for (int i = 0; i < m; i++) {
        dp[i] = (Cell*)malloc(n * sizeof(Cell));
        for (int j = 0; j < n; j++) {
            dp[i][j].score = -1;
            dp[i][j].paths = 0;
        }
    }

    dp[m-1][n-1].score = board[m-1][n-1];
    dp[m-1][n-1].paths = 1;

    for (int i = m-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (i < m-1) {
                if (dp[i][j].score < dp[i+1][j].score) {
                    dp[i][j].score = dp[i+1][j].score;
                    dp[i][j].paths = dp[i+1][j].paths;
                } else if (dp[i][j].score == dp[i+1][j].score) {
                    dp[i][j].paths = (dp[i][j].paths + dp[i+1][j].paths) % MOD;
                }
            }
            if (j < n-1) {
                if (dp[i][j].score < dp[i][j+1].score) {
                    dp[i][j].score = dp[i][j+1].score;
                    dp[i][j].paths = dp[i][j+1].paths;
                } else if (dp[i][j].score == dp[i][j+1].score) {
                    dp[i][j].paths = (dp[i][j].paths + dp[i][j+1].paths) % MOD;
                }
            }
            if (i < m-1 || j < n-1) {
                dp[i][j].score += board[i][j];
            }
        }
    }

    Cell result = {0, 0};
    if (dp[0][0].score >= 0) {
        result.score = dp[0][0].score;
        result.paths = dp[0][0].paths;
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}