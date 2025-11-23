#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool dfs(char *grid, int m, int n, int i, int j, int open, int close) {
    if (i >= m || j >= n) return false;
    if (grid[i * n + j] == '(') open++;
    else close++;
    if (open < close) return false;
    if (i == m - 1 && j == n - 1) return open == close;
    return dfs(grid, m, n, i + 1, j, open, close) || dfs(grid, m, n, i, j + 1, open, close);
}

bool checkValidString(char *grid, int m, int n) {
    return dfs(grid, m, n, 0, 0, 0, 0);
}