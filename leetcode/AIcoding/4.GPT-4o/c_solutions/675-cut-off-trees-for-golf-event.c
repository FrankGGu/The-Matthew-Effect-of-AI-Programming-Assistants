#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX 1000

typedef struct {
    int x, y, height;
} Tree;

int cmp(const void *a, const void *b) {
    return ((Tree *)a)->height - ((Tree *)b)->height;
}

int bfs(int** grid, int startX, int startY, int targetX, int targetY, int row, int col) {
    if (startX == targetX && startY == targetY) return 0;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int visited[MAX][MAX] = {0};
    visited[startX][startY] = 1;
    int queue[MAX * MAX][2], front = 0, rear = 0;
    queue[rear][0] = startX;
    queue[rear++][1] = startY;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;
            if (x == targetX && y == targetY) return steps;

            for (int j = 0; j < 4; j++) {
                int newX = x + directions[j][0];
                int newY = y + directions[j][1];
                if (newX >= 0 && newX < row && newY >= 0 && newY < col && grid[newX][newY] != 0 && !visited[newX][newY]) {
                    visited[newX][newY] = 1;
                    queue[rear][0] = newX;
                    queue[rear++][1] = newY;
                }
            }
        }
        steps++;
    }
    return -1;
}

int cutOffTree(int** forest, int forestSize, int* forestColSize) {
    int row = forestSize, col = *forestColSize;
    Tree trees[MAX];
    int treeCount = 0;

    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            if (forest[i][j] > 1) {
                trees[treeCount++] = (Tree){i, j, forest[i][j]};
            }
        }
    }

    qsort(trees, treeCount, sizeof(Tree), cmp);

    int startX = 0, startY = 0, totalSteps = 0;
    for (int i = 0; i < treeCount; i++) {
        int steps = bfs(forest, startX, startY, trees[i].x, trees[i].y, row, col);
        if (steps == -1) return -1;
        totalSteps += steps;
        startX = trees[i].x;
        startY = trees[i].y;
    }

    return totalSteps;
}