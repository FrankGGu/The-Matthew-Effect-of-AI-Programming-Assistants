#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* points;
    int size;
} Path;

int cmpfunc(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

bool is_valid(Point p, int n, int m) {
    return p.x >= 0 && p.x < n && p.y >= 0 && p.y < m;
}

int minTimeToVisitAllPoints(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int time = 0;
    for (int i = 0; i < n - 1; i++) {
        int dx = abs(grid[i][0] - grid[i + 1][0]);
        int dy = abs(grid[i][1] - grid[i + 1][1]);
        time += fmax(dx, dy);
    }
    return time;
}