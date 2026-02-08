#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int m, n;
    scanf("%d %d", &m, &n);
    int **grid = (int **)malloc(m * sizeof(int *));
    for (int i = 0; i < m; i++) {
        grid[i] = (int *)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            scanf("%d", &grid[i][j]);
        }
    }

    int count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                count++;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(grid[i]);
    }
    free(grid);

    return count;
}