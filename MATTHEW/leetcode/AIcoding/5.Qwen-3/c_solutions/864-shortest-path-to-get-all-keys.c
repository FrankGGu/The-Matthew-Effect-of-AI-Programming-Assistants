#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
    int keys;
} State;

int dx[] = {-1, 0, 1, 0};
int dy[] = {0, 1, 0, -1};

int bfs(char** grid, int rows, int cols) {
    int startx = -1, starty = -1;
    int keycount = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == '@') {
                startx = i;
                starty = j;
            } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                keycount++;
            }
        }
    }

    int targetkeys = (1 << keycount) - 1;

    int visited[rows][cols][1 << 6];
    memset(visited, 0, sizeof(visited));

    State queue[rows * cols * (1 << 6)];
    int front = 0, rear = 0;

    queue[rear].x = startx;
    queue[rear].y = starty;
    queue[rear].keys = 0;
    rear++;

    visited[startx][starty][0] = 1;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            State curr = queue[front];
            front++;

            if (curr.keys == targetkeys) {
                return steps;
            }

            for (int d = 0; d < 4; d++) {
                int nx = curr.x + dx[d];
                int ny = curr.y + dy[d];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                    char c = grid[nx][ny];
                    if (c == '#') continue;

                    int newkeys = curr.keys;
                    if (c >= 'a' && c <= 'f') {
                        newkeys |= (1 << (c - 'a'));
                    }

                    if (c >= 'A' && c <= 'F' && !(curr.keys & (1 << (c - 'A')))) {
                        continue;
                    }

                    if (!visited[nx][ny][newkeys]) {
                        visited[nx][ny][newkeys] = 1;
                        queue[rear].x = nx;
                        queue[rear].y = ny;
                        queue[rear].keys = newkeys;
                        rear++;
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}

int shortestPathToGetAllKeys(char** grid, int gridSize, int* gridColSize) {
    return bfs(grid, gridSize, gridColSize[0]);
}