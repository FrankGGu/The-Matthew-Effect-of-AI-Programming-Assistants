#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dx[] = {0, 1, 0, -1};
int dy[] = {1, 0, -1, 0};

bool dfs(char** board, int rows, int cols, int x, int y, int dir, int* end_x, int* end_y) {
    while (x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] != '1') {
        x += dx[dir];
        y += dy[dir];
    }

    if (x < 0 || x >= rows || y < 0 || y >= cols) {
        *end_x = x - dx[dir];
        *end_y = y - dy[dir];
        return false;
    }

    x -= dx[dir];
    y -= dy[dir];

    if ((x == 0 || x == rows - 1 || y == 0 || y == cols - 1)) {
        *end_x = x;
        *end_y = y;
        return true;
    }

    *end_x = x;
    *end_y = y;
    return false;
}

bool hasPath(char** board, int rows, int cols, int start_x, int start_y, int end_x, int end_y) {
    bool visited[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int qx[rows * cols];
    int qy[rows * cols];
    int qd[rows * cols];
    int head = 0, tail = 0;

    for (int i = 0; i < 4; i++) {
        int nx = start_x + dx[i];
        int ny = start_y + dy[i];
        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && board[nx][ny] == '0') {
            qx[tail] = start_x;
            qy[tail] = start_y;
            qd[tail] = i;
            tail++;
        }
    }

    while (head < tail) {
        int x = qx[head];
        int y = qy[head];
        int dir = qd[head];
        head++;

        int new_x, new_y;
        if (dfs(board, rows, cols, x, y, dir, &new_x, &new_y)) {
            if (new_x == end_x && new_y == end_y) {
                return true;
            }
        } else {
             if (new_x == end_x && new_y == end_y) {
                return true;
            }
        }

        if (new_x >= 0 && new_x < rows && new_y >= 0 && new_y < cols) {
            if (!visited[new_x][new_y]) {
                visited[new_x][new_y] = true;
                 for (int i = 0; i < 4; i++) {
                    if (i != dir)
                    {
                        int nx = new_x + dx[i];
                        int ny = new_y + dy[i];
                        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && board[nx][ny] == '0') {
                            qx[tail] = new_x;
                            qy[tail] = new_y;
                            qd[tail] = i;
                            tail++;
                        }
                    }
                }
            }
        }
    }

    return false;
}