#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int** maze;
int rows, cols;
int** visited;
Point start, end;

int dx[] = {-1, 0, 1, 0};
int dy[] = {0, 1, 0, -1};

int dfs(int x, int y) {
    if (x == end.x && y == end.y) {
        return 1;
    }
    visited[x][y] = 1;
    for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && maze[nx][ny] == 0) {
            if (dfs(nx, ny)) {
                return 1;
            }
        }
    }
    return 0;
}

int escapeMaze(int** maze, int mazeSize, int* mazeColSize) {
    rows = mazeSize;
    cols = mazeColSize[0];
    maze = maze;
    visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = 0;
        }
    }
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (maze[i][j] == 2) {
                start.x = i;
                start.y = j;
            } else if (maze[i][j] == 3) {
                end.x = i;
                end.y = j;
            }
        }
    }
    int result = dfs(start.x, start.y);
    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return result;
}