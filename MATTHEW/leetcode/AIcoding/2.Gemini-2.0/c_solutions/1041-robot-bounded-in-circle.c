#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isRobotBounded(char * instructions){
    int x = 0, y = 0;
    int dx = 0, dy = 1;

    for (int i = 0; i < strlen(instructions); i++) {
        if (instructions[i] == 'G') {
            x += dx;
            y += dy;
        } else if (instructions[i] == 'L') {
            int temp = dx;
            dx = -dy;
            dy = temp;
        } else {
            int temp = dx;
            dx = dy;
            dy = -temp;
        }
    }

    return (x == 0 && y == 0) || (dx != 0 || dy != 1);
}