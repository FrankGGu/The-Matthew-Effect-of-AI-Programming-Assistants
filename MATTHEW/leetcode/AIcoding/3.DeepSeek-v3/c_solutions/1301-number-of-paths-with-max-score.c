/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* pathsWithMaxScore(char** board, int boardSize, int* boardColSize, int* returnSize) {
    int n = boardSize;
    int mod = 1e9 + 7;

    int** dp_sum = (int**)malloc(n * sizeof(int*));
    int** dp_count = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp_sum[i] = (int*)malloc(n * sizeof(int));
        dp_count[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp_sum[i][j] = -1;
            dp_count[i][j] = 0;
        }
    }

    dp_sum[n-1][n-1] = 0;
    dp_count[n-1][n-1] = 1;

    for (int i = n-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (board[i][j] == 'X') continue;
            if (i == n-1 && j == n-1) continue;

            int max_sum = -1;
            int count = 0;

            int directions[3][2] = {{1, 1}, {1, 0}, {0, 1}};
            for (int k = 0; k < 3; k++) {
                int ni = i + directions[k][0];
                int nj = j + directions[k][1];

                if (ni < n && nj < n && dp_sum[ni][nj] != -1) {
                    if (dp_sum[ni][nj] > max_sum) {
                        max_sum = dp_sum[ni][nj];
                        count = dp_count[ni][nj];
                    } else if (dp_sum[ni][nj] == max_sum) {
                        count = (count + dp_count[ni][nj]) % mod;
                    }
                }
            }

            if (max_sum != -1) {
                int val = 0;
                if (board[i][j] != 'E' && board[i][j] != 'S') {
                    val = board[i][j] - '0';
                }
                dp_sum[i][j] = max_sum + val;
                dp_count[i][j] = count;
            }
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    if (dp_count[0][0] == 0) {
        result[0] = 0;
        result[1] = 0;
    } else {
        result[0] = dp_sum[0][0];
        result[1] = dp_count[0][0];
    }

    for (int i = 0; i < n; i++) {
        free(dp_sum[i]);
        free(dp_count[i]);
    }
    free(dp_sum);
    free(dp_count);

    return result;
}