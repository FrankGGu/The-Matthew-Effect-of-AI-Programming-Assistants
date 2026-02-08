#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
    int height;
} Tree;

int compare(const void *a, const void *b) {
    return ((Tree *)a)->height - ((Tree *)b)->height;
}

int bfs(int** forest, int forestSize, int* forestColSize, int startX, int startY, int endX, int endY) {
    int rows = forestSize;
    int cols = forestColSize[0];
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int** distance = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        distance[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            distance[i][j] = -1;
        }
    }

    distance[startX][startY] = 0;
    visited[startX][startY] = true;

    int queue[rows * cols][2];
    int head = 0;
    int tail = 0;
    queue[tail][0] = startX;
    queue[tail][1] = startY;
    tail++;

    while (head < tail) {
        int currX = queue[head][0];
        int currY = queue[head][1];
        head++;

        if (currX == endX && currY == endY) {
            int result = distance[endX][endY];
            for (int i = 0; i < rows; i++) {
                free(visited[i]);
                free(distance[i]);
            }
            free(visited);
            free(distance);
            return result;
        }

        for (int i = 0; i < 4; i++) {
            int nextX = currX + dx[i];
            int nextY = currY + dy[i];

            if (nextX >= 0 && nextX < rows && nextY >= 0 && nextY < cols && forest[nextX][nextY] != 0 && !visited[nextX][nextY]) {
                visited[nextX][nextY] = true;
                distance[nextX][nextY] = distance[currX][currY] + 1;
                queue[tail][0] = nextX;
                queue[tail][1] = nextY;
                tail++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
        free(distance[i]);
    }
    free(visited);
    free(distance);

    return -1;
}

int cutOffTree(int** forest, int forestSize, int* forestColSize) {
    int rows = forestSize;
    int cols = forestColSize[0];

    Tree trees[rows * cols];
    int treeCount = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (forest[i][j] > 1) {
                trees[treeCount].x = i;
                trees[treeCount].y = j;
                trees[treeCount].height = forest[i][j];
                treeCount++;
            }
        }
    }

    qsort(trees, treeCount, sizeof(Tree), compare);

    int currX = 0;
    int currY = 0;
    int totalSteps = 0;

    for (int i = 0; i < treeCount; i++) {
        int steps = bfs(forest, forestSize, forestColSize, currX, currY, trees[i].x, trees[i].y);
        if (steps == -1) {
            return -1;
        }
        totalSteps += steps;
        currX = trees[i].x;
        currY = trees[i].y;
    }

    return totalSteps;
}