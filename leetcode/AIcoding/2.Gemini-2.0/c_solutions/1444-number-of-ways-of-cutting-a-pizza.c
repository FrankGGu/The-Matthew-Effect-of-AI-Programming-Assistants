#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ways(char** pizza, int pizzaSize, int* pizzaColSize, int k) {
    int rows = pizzaSize;
    int cols = pizzaColSize[0];
    int mod = 1000000007;

    int*** dp = (int***)malloc((k + 1) * sizeof(int**));
    for (int i = 0; i <= k; i++) {
        dp[i] = (int**)malloc(rows * sizeof(int*));
        for (int j = 0; j < rows; j++) {
            dp[i][j] = (int*)malloc(cols * sizeof(int));
            memset(dp[i][j], -1, cols * sizeof(int));
        }
    }

    int** apples = (int**)malloc((rows + 1) * sizeof(int*));
    for (int i = 0; i <= rows; i++) {
        apples[i] = (int*)malloc((cols + 1) * sizeof(int));
        memset(apples[i], 0, (cols + 1) * sizeof(int));
    }

    for (int r = rows - 1; r >= 0; r--) {
        for (int c = cols - 1; c >= 0; c--) {
            apples[r][c] = apples[r + 1][c] + apples[r][c + 1] - apples[r + 1][c + 1] + (pizza[r][c] == 'A');
        }
    }

    int solve(int row, int col, int cuts) {
        if (cuts == 1) {
            return apples[row][col] > 0;
        }

        if (dp[cuts][row][col] != -1) {
            return dp[cuts][row][col];
        }

        int ans = 0;

        for (int i = row + 1; i < rows; i++) {
            if (apples[row][col] - apples[i][col] > 0) {
                ans = (ans + solve(i, col, cuts - 1)) % mod;
            }
        }

        for (int j = col + 1; j < cols; j++) {
            if (apples[row][col] - apples[row][j] > 0) {
                ans = (ans + solve(row, j, cuts - 1)) % mod;
            }
        }

        return dp[cuts][row][col] = ans;
    }

    int result = solve(0, 0, k);

    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < rows; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    for (int i = 0; i <= rows; i++) {
        free(apples[i]);
    }
    free(apples);

    return result;
}