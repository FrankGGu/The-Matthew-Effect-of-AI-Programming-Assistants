#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 100000

typedef struct {
    int x, y, cost;
} Node;

int minObstacleRemoval(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
    int row = gridSize, col = gridColSize[0];
    int** dist = (int**)malloc(row * sizeof(int*));
    for (int i = 0; i < row; i++) {
        dist[i] = (int*)malloc(col * sizeof(int));
        for (int j = 0; j < col; j++) {
            dist[i][j] = MAX;
        }
    }

    dist[0][0] = 0;
    Node* queue = (Node*)malloc(row * col * sizeof(Node));
    int head = 0, tail = 0;
    queue[tail++] = (Node){0, 0, 0};

    while (head < tail) {
        Node current = queue[head++];
        int x = current.x, y = current.y, cost = current.cost;

        if (x == row - 1 && y == col - 1) {
            free(queue);
            for (int i = 0; i < row; i++) free(dist[i]);
            free(dist);
            return cost;
        }

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX >= 0 && newX < row && newY >= 0 && newY < col) {
                int newCost = cost + grid[newX][newY];
                if (newCost < dist[newX][newY]) {
                    dist[newX][newY] = newCost;
                    queue[tail++] = (Node){newX, newY, newCost};
                }
            }
        }
    }

    free(queue);
    for (int i = 0; i < row; i++) free(dist[i]);
    free(dist);
    return -1;
}