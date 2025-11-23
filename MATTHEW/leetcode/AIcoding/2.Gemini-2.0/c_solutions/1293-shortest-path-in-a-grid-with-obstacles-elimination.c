#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int row;
    int col;
    int k;
    int dist;
};

int shortestPath(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];

    if (rows == 1 && cols == 1) return 0;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    int visited[rows][cols][k + 1];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            for (int l = 0; l <= k; l++) {
                visited[i][j][l] = 0;
            }
        }
    }

    struct Node queue[rows * cols * (k + 1)];
    int head = 0, tail = 0;

    queue[tail++] = (struct Node){0, 0, k, 0};
    visited[0][0][k] = 1;

    while (head < tail) {
        struct Node curr = queue[head++];

        if (curr.row == rows - 1 && curr.col == cols - 1) {
            return curr.dist;
        }

        for (int i = 0; i < 4; i++) {
            int newRow = curr.row + dx[i];
            int newCol = curr.col + dy[i];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                if (grid[newRow][newCol] == 0 && !visited[newRow][newCol][curr.k]) {
                    queue[tail++] = (struct Node){newRow, newCol, curr.k, curr.dist + 1};
                    visited[newRow][newCol][curr.k] = 1;
                } else if (grid[newRow][newCol] == 1 && curr.k > 0 && !visited[newRow][newCol][curr.k - 1]) {
                    queue[tail++] = (struct Node){newRow, newCol, curr.k - 1, curr.dist + 1};
                    visited[newRow][newCol][curr.k - 1] = 1;
                }
            }
        }
    }

    return -1;
}