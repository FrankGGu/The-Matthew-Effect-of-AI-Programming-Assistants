#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int minDays(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    Point points[100];
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                points[count].x = i;
                points[count].y = j;
                count++;
            }
        }
    }
    qsort(points, count, sizeof(Point), cmp);
    if (count == 0) return 0;
    if (count == 1) return 1;
    int dx[] = {-1, 0, 1, 0};
    int dy[] = {0, 1, 0, -1};
    int visited[100];
    int dfs(int idx, int start) {
        visited[idx] = 1;
        for (int i = 0; i < 4; i++) {
            int nx = points[idx].x + dx[i];
            int ny = points[idx].y + dy[i];
            for (int j = 0; j < count; j++) {
                if (points[j].x == nx && points[j].y == ny && !visited[j]) {
                    if (j == start) return 1;
                    if (dfs(j, start)) return 1;
                }
            }
        }
        return 0;
    }
    for (int i = 0; i < count; i++) {
        memset(visited, 0, sizeof(visited));
        visited[i] = 1;
        int flag = 0;
        for (int j = 0; j < count; j++) {
            if (j != i && !visited[j]) {
                if (dfs(j, i)) {
                    flag = 1;
                    break;
                }
            }
        }
        if (!flag) return 1;
    }
    return 2;
}