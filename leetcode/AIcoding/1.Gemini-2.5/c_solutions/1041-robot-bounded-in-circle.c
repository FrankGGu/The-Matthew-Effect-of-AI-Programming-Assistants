#include <stdbool.h>

bool isRobotBounded(char * instructions){
    int x = 0;
    int y = 0;
    int dir = 0; // 0: North, 1: East, 2: South, 3: West

    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    for (int i = 0; instructions[i] != '\0'; i++) {
        char instruction = instructions[i];
        if (instruction == 'G') {
            x += dx[dir];
            y += dy[dir];
        } else if (instruction == 'L') {
            dir = (dir + 3) % 4;
        } else { // instruction == 'R'
            dir = (dir + 1) % 4;
        }
    }

    return (x == 0 && y == 0) || (dir != 0);
}