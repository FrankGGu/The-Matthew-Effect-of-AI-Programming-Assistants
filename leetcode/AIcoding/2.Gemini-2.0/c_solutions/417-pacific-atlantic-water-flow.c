#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** pacificAtlantic(int** heights, int heightsSize, int* heightsColSize, int* returnSize, int** returnColumnSizes) {
    if (heightsSize == 0 || *heightsColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = heightsSize;
    int cols = *heightsColSize;

    bool pacific[rows][cols];
    bool atlantic[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            pacific[i][j] = false;
            atlantic[i][j] = false;
        }
    }

    void dfs(int row, int col, bool visited[][cols], int prevHeight, int** heights) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || visited[row][col] || heights[row][col] < prevHeight) {
            return;
        }

        visited[row][col] = true;

        dfs(row + 1, col, visited, heights[row][col], heights);
        dfs(row - 1, col, visited, heights[row][col], heights);
        dfs(row, col + 1, visited, heights[row][col], heights);
        dfs(row, col - 1, visited, heights[row][col], heights);
    }

    for (int i = 0; i < rows; i++) {
        dfs(i, 0, pacific, -1, heights);
        dfs(i, cols - 1, atlantic, -1, heights);
    }

    for (int j = 0; j < cols; j++) {
        dfs(0, j, pacific, -1, heights);
        dfs(rows - 1, j, atlantic, -1, heights);
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                count++;
            }
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = i;
                result[*returnSize][1] = j;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
        }
    }

    return result;
}