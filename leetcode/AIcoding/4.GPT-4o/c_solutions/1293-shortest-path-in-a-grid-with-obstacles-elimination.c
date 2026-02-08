#include <stdbool.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x, y, k, dist;
} Node;

int shortestPath(int** grid, int gridSize, int* gridColSize, int k) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int row = gridSize, col = *gridColSize;
    int maxK = k + 1;
    int*** visited = (int***)malloc(row * sizeof(int**));
    for (int i = 0; i < row; i++) {
        visited[i] = (int**)malloc(col * sizeof(int*));
        for (int j = 0; j < col; j++) {
            visited[i][j] = (int*)calloc(maxK, sizeof(int));
            for (int l = 0; l < maxK; l++) {
                visited[i][j][l] = INT_MAX;
            }
        }
    }

    Node start = {0, 0, k, 0};
    visited[0][0][k] = 0;

    int front = 0, rear = 1;
    Node* queue = (Node*)malloc(row * col * maxK * sizeof(Node));
    queue[front] = start;

    while (front < rear) {
        Node curr = queue[front++];
        if (curr.x == row - 1 && curr.y == col - 1) {
            free(queue);
            for (int i = 0; i < row; i++) {
                for (int j = 0; j < col; j++) {
                    free(visited[i][j]);
                }
                free(visited[i]);
            }
            free(visited);
            return curr.dist;
        }

        for (int i = 0; i < 4; i++) {
            int newX = curr.x + directions[i][0];
            int newY = curr.y + directions[i][1];
            if (newX >= 0 && newX < row && newY >= 0 && newY < col) {
                int newK = curr.k - grid[newX][newY];
                if (newK >= 0 && curr.dist + 1 < visited[newX][newY][newK]) {
                    visited[newX][newY][newK] = curr.dist + 1;
                    queue[rear++] = (Node){newX, newY, newK, curr.dist + 1};
                }
            }
        }
    }

    free(queue);
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            free(visited[i][j]);
        }
        free(visited[i]);
    }
    free(visited);
    return -1;
}