#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x, y;
} Point;

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int swimInWater(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int left = 0, right = n * n, res = right;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    while (left <= right) {
        int mid = left + (right - left) / 2;
        bool visited[n][n];
        memset(visited, false, sizeof(visited));

        Point queue[n * n];
        int front = 0, back = 0;

        if (grid[0][0] <= mid) {
            queue[back++] = (Point){0, 0};
            visited[0][0] = true;
        }

        while (front < back) {
            Point p = queue[front++];
            if (p.x == n - 1 && p.y == n - 1) {
                res = mid;
                right = mid - 1;
                break;
            }
            for (int i = 0; i < 4; i++) {
                int newX = p.x + directions[i][0];
                int newY = p.y + directions[i][1];
                if (newX >= 0 && newY >= 0 && newX < n && newY < n && 
                    !visited[newX][newY] && grid[newX][newY] <= mid) {
                    visited[newX][newY] = true;
                    queue[back++] = (Point){newX, newY};
                }
            }
        }

        if (front == back) {
            left = mid + 1;
        }
    }

    return res;
}