#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLatestDay(int row, int col, int** cells, int cellsSize, int* cellsColSize) {
    int left = 1, right = cellsSize;
    int latestDay = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int** grid = (int**)malloc(row * sizeof(int*));
        for (int i = 0; i < row; i++) {
            grid[i] = (int*)malloc(col * sizeof(int));
            for (int j = 0; j < col; j++) {
                grid[i][j] = 0;
            }
        }

        for (int i = 0; i < mid; i++) {
            grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
        }

        bool canCross = false;
        for (int i = 0; i < col; i++) {
            if (grid[0][i] == 0) {
                int* visited = (int*)malloc(row * col * sizeof(int));
                for(int k = 0; k < row * col; k++) visited[k] = 0;

                bool reached = false;
                int stack[row * col][2];
                int top = -1;

                stack[++top][0] = 0;
                stack[top][1] = i;

                while(top >= 0){
                    int currRow = stack[top][0];
                    int currCol = stack[top][1];
                    top--;

                    if(currRow == row - 1){
                        reached = true;
                        break;
                    }

                    int index = currRow * col + currCol;
                    if(visited[index]) continue;
                    visited[index] = 1;

                    int dr[] = {-1, 1, 0, 0};
                    int dc[] = {0, 0, -1, 1};

                    for(int k = 0; k < 4; k++){
                        int newRow = currRow + dr[k];
                        int newCol = currCol + dc[k];

                        if(newRow >= 0 && newRow < row && newCol >= 0 && newCol < col && grid[newRow][newCol] == 0){
                            stack[++top][0] = newRow;
                            stack[top][1] = newCol;
                        }
                    }
                }

                free(visited);
                if (reached) {
                    canCross = true;
                    break;
                }
            }
        }

        for (int i = 0; i < row; i++) {
            free(grid[i]);
        }
        free(grid);

        if (canCross) {
            latestDay = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return latestDay;
}