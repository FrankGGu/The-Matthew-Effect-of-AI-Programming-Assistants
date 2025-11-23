#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Position;

int dfs(char** maze, int rows, int cols, int startRow, int startCol, char* target) {
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int visited[rows][cols];
    memset(visited, 0, sizeof(visited));

    Position stack[rows * cols];
    int top = -1;

    stack[++top] = (Position){startRow, startCol};
    visited[startRow][startCol] = 1;

    while (top >= 0) {
        Position current = stack[top];
        int x = current.x;
        int y = current.y;

        if (strncmp(&maze[x][y], target, strlen(target)) == 0) {
            return 1;
        }

        int found = 0;
        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                visited[nx][ny] = 1;
                stack[++top] = (Position){nx, ny};
                found = 1;
                break;
            }
        }

        if (!found) {
            top--;
        }
    }

    return 0;
}

int exist(char** board, int boardSize, int* boardColSize, char* word) {
    int rows = boardSize;
    int cols = boardColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == word[0] && dfs(board, rows, cols, i, j, word)) {
                return 1;
            }
        }
    }

    return 0;
}