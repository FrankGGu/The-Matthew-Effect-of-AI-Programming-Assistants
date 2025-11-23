#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    int max_val;
    long long count;
} Result;

Result** dp;
char** grid;
int rows, cols;

Result* create_result(int val, long long cnt) {
    Result* res = (Result*)malloc(sizeof(Result));
    res->max_val = val;
    res->count = cnt;
    return res;
}

Result* dfs(int i, int j) {
    if (i >= rows || j >= cols) return create_result(0, 0);
    if (i == rows - 1 && j == cols - 1) {
        return create_result(grid[i][j] - '0', 1);
    }

    if (dp[i][j] != NULL) return dp[i][j];

    Result* down = dfs(i + 1, j);
    Result* right = dfs(i, j + 1);
    Result* diag = dfs(i + 1, j + 1);

    int max_val = -1;
    long long total_count = 0;

    if (down->max_val > max_val) {
        max_val = down->max_val;
        total_count = down->count;
    } else if (down->max_val == max_val) {
        total_count += down->count;
    }

    if (right->max_val > max_val) {
        max_val = right->max_val;
        total_count = right->count;
    } else if (right->max_val == max_val) {
        total_count += right->count;
    }

    if (diag->max_val > max_val) {
        max_val = diag->max_val;
        total_count = diag->count;
    } else if (diag->max_val == max_val) {
        total_count += diag->count;
    }

    int current_val = grid[i][j] - '0';
    max_val += current_val;

    Result* res = create_result(max_val, total_count % MOD);
    dp[i][j] = res;

    return res;
}

int* maxScorePaths(char** board, int boardSize, int* boardColSize, int* returnSize) {
    rows = boardSize;
    cols = boardColSize[0];
    grid = board;

    dp = (Result**)malloc(rows * sizeof(Result*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (Result*)malloc(cols * sizeof(Result));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = NULL;
        }
    }

    Result* result = dfs(0, 0);
    int* output = (int*)malloc(2 * sizeof(int));
    output[0] = result->max_val;
    output[1] = (int)(result->count % MOD);
    *returnSize = 2;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return output;
}