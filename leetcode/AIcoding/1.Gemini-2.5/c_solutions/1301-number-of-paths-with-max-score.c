#include <stdlib.h>

#define MOD 1000000007

typedef struct {
    int score;
    int paths;
} PathInfo;

int* pathsWithMaxScore(char** board, int boardSize, int* boardColSize, int* returnSize) {
    int R = boardSize;
    int C = boardColSize[0];

    PathInfo** dp = (PathInfo**)malloc(R * sizeof(PathInfo*));
    for (int i = 0; i < R; ++i) {
        dp[i] = (PathInfo*)malloc(C * sizeof(PathInfo));
        for (int j = 0; j < C; ++j) {
            dp[i][j].score = -1;
            dp[i][j].paths = 0;
        }
    }

    dp[R - 1][C - 1].score = 0;
    dp[R - 1][C - 1].paths = 1;

    for (int i = R - 1; i >= 0; --i) {
        for (int j = C - 1; j >= 0; --j) {
            if (board[i][j] == 'X' || dp[i][j].paths == 0) {
                continue;
            }

            if (i == 0 && j == 0) {
                continue;
            }

            int val_to_add = 0;
            if (board[i][j] >= '0' && board[i][j] <= '9') {
                val_to_add = board[i][j] - '0';
            }

            int dr[] = {-1, 0, -1};
            int dc[] = {0, -1, -1};

            for (int k = 0; k < 3; ++k) {
                int ni = i + dr[k];
                int nj = j + dc[k];

                if (ni >= 0 && ni < R && nj >= 0 && nj < C && board[ni][nj] != 'X') {
                    int current_path_score = dp[i][j].score + val_to_add;
                    int current_path_count = dp[i][j].paths;

                    if (current_path_score > dp[ni][nj].score) {
                        dp[ni][nj].score = current_path_score;
                        dp[ni][nj].paths = current_path_count;
                    } else if (current_path_score == dp[ni][nj].score) {
                        dp[ni][nj].paths = (dp[ni][nj].paths + current_path_count) % MOD;
                    }
                }
            }
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    if (dp[0][0].paths == 0) {
        result[0] = 0;
        result[1] = 0;
    } else {
        result[0] = dp[0][0].score;
        result[1] = dp[0][0].paths;
    }

    for (int i = 0; i < R; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}