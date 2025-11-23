#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];

    int initialState = 0;
    for (int i = 0; i < n / 2; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] != grid[n - 1 - i][j]) {
                initialState |= (1 << (i * m + j));
            }
        }
    }

    int dp[1 << (n * m / 2)];
    for (int i = 0; i < (1 << (n * m / 2)); i++) {
        dp[i] = -1;
    }

    dp[initialState] = 0;

    int queue[1 << (n * m / 2)];
    int head = 0, tail = 0;
    queue[tail++] = initialState;

    while (head < tail) {
        int currState = queue[head++];

        for (int i = 0; i < n / 2; i++) {
            for (int j = 0; j < m; j++) {
                int nextState = currState ^ (1 << (i * m + j));

                if (dp[nextState] == -1) {
                    dp[nextState] = dp[currState] + 1;
                    queue[tail++] = nextState;
                }
            }
        }
    }

    return (dp[0] == -1) ? -1 : dp[0];
}