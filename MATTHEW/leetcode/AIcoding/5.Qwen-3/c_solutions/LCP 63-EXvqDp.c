#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
    int steps;
} State;

int findMinSteps(char** board, int boardSize, int* boardColSize, int x, int y) {
    int rows = boardSize;
    int cols = boardColSize[0];
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], -1, cols * sizeof(int));
    }

    int dx[] = {-1, 1, 0, 0};
    int dy[] = {0, 0, -1, 1};

    State queue[rows * cols];
    int front = 0, rear = 0;
    queue[rear].x = x;
    queue[rear].y = y;
    queue[rear].steps = 0;
    rear++;
    visited[x][y] = 0;

    while (front < rear) {
        State current = queue[front];
        front++;

        for (int i = 0; i < 4; i++) {
            int nx = current.x + dx[i];
            int ny = current.y + dy[i];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && board[nx][ny] != 'X') {
                if (visited[nx][ny] == -1 || current.steps + 1 < visited[nx][ny]) {
                    visited[nx][ny] = current.steps + 1;
                    queue[rear].x = nx;
                    queue[rear].y = ny;
                    queue[rear].steps = current.steps + 1;
                    rear++;
                }
            }
        }
    }

    int minSteps = -1;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == 'O') {
                if (minSteps == -1 || visited[i][j] < minSteps) {
                    minSteps = visited[i][j];
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return minSteps;
}

int findBall(char** board, int boardSize, int* boardColSize) {
    int rows = boardSize;
    int cols = boardColSize[0];
    int result = -1;

    for (int j = 0; j < cols; j++) {
        int x = 0;
        int y = j;
        int steps = 0;
        while (x < rows) {
            int nextY = y;
            if (board[x][y] == 'L') {
                nextY = y - 1;
            } else {
                nextY = y + 1;
            }
            if (nextY < 0 || nextY >= cols || board[x][nextY] != board[x][y]) {
                break;
            }
            x++;
            y = nextY;
            steps++;
        }
        if (x == rows) {
            if (result == -1 || steps < result) {
                result = steps;
            }
        }
    }

    return result;
}