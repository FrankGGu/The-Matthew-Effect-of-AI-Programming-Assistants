#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* countBlackBlocks(int m, int n, int** coordinates, int coordinatesSize, int* coordinatesColSize) {
    long long* result = (long long*)calloc(5, sizeof(long long));
    long long total = (long long)(m - 1) * (n - 1);
    int* grid = (int*)calloc(m * n, sizeof(int));

    for (int i = 0; i < coordinatesSize; i++) {
        int row = coordinates[i][0];
        int col = coordinates[i][1];
        grid[(row - 1) * n + (col - 1)] = 1;
    }

    long long two = 0;
    long long three = 0;
    long long four = 0;
    long long one = 0;
    long long zero = 0;

    for (int i = 0; i < m - 1; i++) {
        for (int j = 0; j < n - 1; j++) {
            int count = 0;
            if (grid[i * n + j] == 1) count++;
            if (grid[i * n + j + 1] == 1) count++;
            if (grid[(i + 1) * n + j] == 1) count++;
            if (grid[(i + 1) * n + j + 1] == 1) count++;

            if (count == 0) result[0]++;
            else if (count == 1) result[1]++;
            else if (count == 2) result[2]++;
            else if (count == 3) result[3]++;
            else result[4]++;
        }
    }

    free(grid);
    return result;
}