#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count = 0;

void dfs(int row, int col, int m, int n) {
    if (row == m - 1 && col == n - 1) {
        count++;
        return;
    }

    if (row + 1 < m) {
        dfs(row + 1, col, m, n);
    }

    if (col + 1 < n) {
        dfs(row, col + 1, m, n);
    }
}

int uniquePaths(int m, int n) {
    count = 0;
    dfs(0, 0, m, n);
    return count;
}