#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int equalSumGrid(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    long long totalSum = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            totalSum += grid[i][j];
        }
    }

    if (totalSum % 2 != 0) {
        return -1;
    }

    long long halfSum = totalSum / 2;
    int count = 0;

    for (int r = 0; r < n; r++) {
        long long rowSum = 0;
        for (int c = 0; c < n; c++) {
            rowSum += grid[r][c];
        }
        if (rowSum == halfSum) {
            count++;
        }
    }
    for (int c = 0; c < n; c++) {
        long long colSum = 0;
        for (int r = 0; r < n; r++) {
            colSum += grid[r][c];
        }
        if (colSum == halfSum) {
            count++;
        }
    }

    long long currentSum = 0;
    for (int i = 0; i < n; i++) {
        currentSum += grid[i][i];
    }
    if (currentSum == halfSum) {
        count++;
    }

    currentSum = 0;
    for (int i = 0; i < n; i++) {
        currentSum += grid[i][n - 1 - i];
    }
    if (currentSum == halfSum) {
        count++;
    }

    int ans = -1;

    for (int r = 0; r < n; r++) {
        for (int c = 0; c < n; c++) {
            long long sum1 = 0;
            for (int i = 0; i <= r; i++) {
                for (int j = 0; j <= c; j++) {
                    sum1 += grid[i][j];
                }
            }
            if (sum1 == halfSum) {
                return 1;
            }
        }
    }

    return -1;
}