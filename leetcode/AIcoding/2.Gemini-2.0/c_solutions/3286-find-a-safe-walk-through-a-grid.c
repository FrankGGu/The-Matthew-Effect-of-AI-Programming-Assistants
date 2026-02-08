#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    int dist;
} QueueNode;

int safeWalk(int** grid, int gridSize, int* gridColSize, int sourceRow, int sourceCol, int destinationRow, int destinationCol) {
    int rows = gridSize;
    int cols = gridColSize[0];

    if (grid[sourceRow][sourceCol] == 0 || grid[destinationRow][destinationCol] == 0) {
        return -1;
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    QueueNode* queue = (QueueNode*)malloc(rows * cols * sizeof(QueueNode));
    int head = 0;
    int tail = 0;

    QueueNode startNode = {sourceRow, sourceCol, 0};
    queue[tail++] = startNode;
    visited[sourceRow][sourceCol] = true;

    while (head < tail) {
        QueueNode current = queue[head++];
        int row = current.row;
        int col = current.col;
        int dist = current.dist;

        if (row == destinationRow && col == destinationCol) {
            for (int i = 0; i < rows; i++) {
                free(visited[i]);
            }
            free(visited);
            free(queue);
            return dist;
        }

        for (int i = 0; i < 4; i++) {
            int newRow = row + dx[i];
            int newCol = col + dy[i];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols &&
                grid[newRow][newCol] == 1 && !visited[newRow][newCol]) {
                QueueNode newNode = {newRow, newCol, dist + 1};
                queue[tail++] = newNode;
                visited[newRow][newCol] = true;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    free(queue);
    return -1;
}