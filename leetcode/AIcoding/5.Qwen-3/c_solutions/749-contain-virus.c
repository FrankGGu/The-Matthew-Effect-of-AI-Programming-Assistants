#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int** grid;
    int gridSize;
    int* gridColSize;
} Solution;

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* points;
    int size;
} Area;

void bfs(int** grid, int gridSize, int* gridColSize, int x, int y, int** visited, Area* area, int* isInfected) {
    int dx[] = {-1, 0, 1, 0};
    int dy[] = {0, 1, 0, -1};
    int q[gridSize * (*gridColSize)];
    int front = 0, rear = 0;
    q[rear++] = x * (*gridColSize) + y;
    visited[x][y] = 1;
    area->points = (Point*)realloc(area->points, (area->size + 1) * sizeof(Point));
    area->points[area->size++] = (Point){x, y};

    while (front < rear) {
        int pos = q[front++];
        int cx = pos / (*gridColSize);
        int cy = pos % (*gridColSize);

        for (int i = 0; i < 4; i++) {
            int nx = cx + dx[i];
            int ny = cy + dy[i];
            if (nx >= 0 && nx < gridSize && ny >= 0 && ny < (*gridColSize) && !visited[nx][ny] && grid[nx][ny] == 1) {
                visited[nx][ny] = 1;
                q[rear++] = nx * (*gridColSize) + ny;
                area->points = (Point*)realloc(area->points, (area->size + 1) * sizeof(Point));
                area->points[area->size++] = (Point){nx, ny};
                if (grid[nx][ny] == 1) {
                    isInfected[0]++;
                }
            }
        }
    }
}

int containVirus(int** grid, int gridSize, int* gridColSize) {
    int total = 0;
    int** visited = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        visited[i] = (int*)calloc(*gridColSize, sizeof(int));
    }

    while (1) {
        int maxArea = -1;
        int bestX = -1;
        int bestY = -1;
        int* isInfected = (int*)calloc(1, sizeof(int));
        Area area = {NULL, 0};

        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < *gridColSize; j++) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    int** tempVisited = (int**)malloc(gridSize * sizeof(int*));
                    for (int k = 0; k < gridSize; k++) {
                        tempVisited[k] = (int*)calloc(*gridColSize, sizeof(int));
                    }
                    Area currentArea = {NULL, 0};
                    int currentInfected = 0;
                    bfs(grid, gridSize, gridColSize, i, j, tempVisited, &currentArea, &currentInfected);
                    int boundary = 0;
                    for (int k = 0; k < currentArea.size; k++) {
                        int x = currentArea.points[k].x;
                        int y = currentArea.points[k].y;
                        int dx[] = {-1, 0, 1, 0};
                        int dy[] = {0, 1, 0, -1};
                        for (int l = 0; l < 4; l++) {
                            int nx = x + dx[l];
                            int ny = y + dy[l];
                            if (nx >= 0 && nx < gridSize && ny >= 0 && ny < *gridColSize && grid[nx][ny] == 0) {
                                boundary++;
                            }
                        }
                    }
                    if (boundary > maxArea) {
                        maxArea = boundary;
                        bestX = i;
                        bestY = j;
                        free(area.points);
                        area = currentArea;
                        *isInfected = currentInfected;
                    }
                    for (int k = 0; k < gridSize; k++) {
                        free(tempVisited[k]);
                    }
                    free(tempVisited);
                }
            }
        }

        if (maxArea == -1) break;
        total += *isInfected;

        for (int i = 0; i < area.size; i++) {
            int x = area.points[i].x;
            int y = area.points[i].y;
            grid[x][y] = 2;
        }

        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < *gridColSize; j++) {
                if (grid[i][j] == 2) {
                    visited[i][j] = 1;
                }
            }
        }

        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < *gridColSize; j++) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    int** tempVisited = (int**)malloc(gridSize * sizeof(int*));
                    for (int k = 0; k < gridSize; k++) {
                        tempVisited[k] = (int*)calloc(*gridColSize, sizeof(int));
                    }
                    Area currentArea = {NULL, 0};
                    int currentInfected = 0;
                    bfs(grid, gridSize, gridColSize, i, j, tempVisited, &currentArea, &currentInfected);
                    for (int k = 0; k < currentArea.size; k++) {
                        int x = currentArea.points[k].x;
                        int y = currentArea.points[k].y;
                        grid[x][y] = 1;
                    }
                    for (int k = 0; k < gridSize; k++) {
                        free(tempVisited[k]);
                    }
                    free(tempVisited);
                }
            }
        }

        free(area.points);
        free(isInfected);
    }

    for (int i = 0; i < gridSize; i++) {
        free(visited[i]);
    }
    free(visited);
    return total;
}