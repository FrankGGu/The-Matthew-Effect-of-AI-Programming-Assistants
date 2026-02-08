#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

bool isRobotBounded(char* instructions) {
    int dir[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // North, East, South, West
    int currentDir = 0;
    int x = 0, y = 0;

    for (int i = 0; i < strlen(instructions); i++) {
        char c = instructions[i];
        if (c == 'G') {
            x += dir[currentDir][0];
            y += dir[currentDir][1];
        } else if (c == 'L') {
            currentDir = (currentDir + 3) % 4;
        } else if (c == 'R') {
            currentDir = (currentDir + 1) % 4;
        }
    }

    return (x == 0 && y == 0) || currentDir != 0;
}