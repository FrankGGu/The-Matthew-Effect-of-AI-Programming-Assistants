#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100

int nearestExit(char** maze, int mazeSize, int* mazeColSize, int* entrance, int entranceSize) {
    int rows = mazeSize;
    int cols = mazeColSize[0];
    int startRow = entrance[0];
    int startCol = entrance[1];

    int queue[MAX_SIZE * MAX_SIZE][2];
    int head = 0;
    int tail = 0;
    queue[tail][0] = startRow;
    queue[tail][1] = startCol;
    tail++;

    maze[startRow][startCol] = '+'; 

    int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    int steps = 0;

    while (head < tail) {
        int queueSize = tail - head;
        for (int i = 0; i < queueSize; i++) {
            int currentRow = queue[head][0];
            int currentCol = queue[head][1];
            head++;

            if ((currentRow == 0 || currentRow == rows - 1 || currentCol == 0 || currentCol == cols - 1) &&
                (currentRow != startRow || currentCol != startCol)) {
                return steps;
            }

            for (int j = 0; j < 4; j++) {
                int newRow = currentRow + directions[j][0];
                int newCol = currentCol + directions[j][1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && maze[newRow][newCol] == '.') {
                    queue[tail][0] = newRow;
                    queue[tail][1] = newCol;
                    tail++;
                    maze[newRow][newCol] = '+'; 
                }
            }
        }
        steps++;
    }

    return -1;
}