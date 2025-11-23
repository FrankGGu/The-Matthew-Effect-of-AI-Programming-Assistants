#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100

typedef struct {
    int row;
    int col;
} QueueNode;

int shortestBridge(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    bool foundIsland1 = false;
    QueueNode queue[MAX_SIZE * MAX_SIZE];
    int head = 0, tail = 0;
    bool visited[MAX_SIZE][MAX_SIZE];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    void dfs(int row, int col) {
        if (row < 0 || row >= n || col < 0 || col >= n || grid[row][col] == 0 || visited[row][col]) {
            return;
        }
        visited[row][col] = true;
        queue[tail].row = row;
        queue[tail].col = col;
        tail++;

        for (int i = 0; i < 4; i++) {
            dfs(row + directions[i][0], col + directions[i][1]);
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                dfs(i, j);
                foundIsland1 = true;
                break;
            }
        }
        if (foundIsland1) break;
    }

    int distance = 0;
    while (head != tail) {
        int queueSize = tail - head;
        for (int i = 0; i < queueSize; i++) {
            QueueNode curr = queue[head++];
            int row = curr.row;
            int col = curr.col;

            for (int j = 0; j < 4; j++) {
                int newRow = row + directions[j][0];
                int newCol = col + directions[j][1];

                if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                    if (grid[newRow][newCol] == 1) {
                        return distance;
                    }
                    visited[newRow][newCol] = true;
                    queue[tail].row = newRow;
                    queue[tail].col = newCol;
                    tail++;
                }
            }
        }
        distance++;
    }

    return -1;
}