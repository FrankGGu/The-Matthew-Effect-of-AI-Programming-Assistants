#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* grid, int gridSize, int* gridColSize, int startRow, int startCol, int endRow, int endCol) {
    int rows = gridSize;
    int cols = *gridColSize;

    if (startRow == endRow && startCol == endCol) {
        return 0;
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    bool visited[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int queue[rows * cols][3];
    int head = 0;
    int tail = 0;

    queue[tail][0] = startRow;
    queue[tail][1] = startCol;
    queue[tail][2] = 0;
    tail++;

    visited[startRow][startCol] = true;

    while (head < tail) {
        int currRow = queue[head][0];
        int currCol = queue[head][1];
        int currSteps = queue[head][2];
        head++;

        if (currRow == endRow && currCol == endCol) {
            return currSteps;
        }

        for (int i = 0; i < 4; i++) {
            int newRow = currRow + dx[i];
            int newCol = currCol + dy[i];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow * cols + newCol] == 0 && !visited[newRow][newCol]) {
                queue[tail][0] = newRow;
                queue[tail][1] = newCol;
                queue[tail][2] = currSteps + 1;
                tail++;
                visited[newRow][newCol] = true;
            }
        }

        if (grid[currRow * cols + currCol] == 0) {
            for (int i = 0; i < rows; i++) {
                if (i != currRow && grid[i * cols + currCol] == 0 && !visited[i][currCol]) {
                    queue[tail][0] = i;
                    queue[tail][1] = currCol;
                    queue[tail][2] = currSteps + 1;
                    tail++;
                    visited[i][currCol] = true;
                }
            }

            for (int j = 0; j < cols; j++) {
                if (j != currCol && grid[currRow * cols + j] == 0 && !visited[currRow][j]) {
                    queue[tail][0] = currRow;
                    queue[tail][1] = j;
                    queue[tail][2] = currSteps + 1;
                    tail++;
                    visited[currRow][j] = true;
                }
            }
        }
    }

    return -1;
}