#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countAsterisks(char* grid, int rows, int cols) {
    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i * cols + j] == '*') {
                count++;
            }
        }
    }
    return count;
}