#include <stdio.h>
#include <stdlib.h>

int* executeInstructions(int n, int m, int* robot, int robotSize, char** instructions, int instructionsSize, int* returnSize) {
    int* result = (int*)malloc(instructionsSize * sizeof(int));
    *returnSize = instructionsSize;

    for (int i = 0; i < instructionsSize; i++) {
        int x = robot[0], y = robot[1];
        int count = 0;
        for (int j = 0; j < strlen(instructions[i]); j++) {
            char dir = instructions[i][j];
            if (dir == 'U') x--;
            else if (dir == 'D') x++;
            else if (dir == 'L') y--;
            else if (dir == 'R') y++;

            if (x < 0 || x >= n || y < 0 || y >= m) break;
            count++;
        }
        result[i] = count;
    }

    return result;
}