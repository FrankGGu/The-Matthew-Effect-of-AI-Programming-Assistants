#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int distanceSquared(Point p1, Point p2) {
    return (p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y);
}

bool isRobotBounded(int* instructions, int instructionsSize) {
    Point start = {0, 0};
    Point end = {0, 0};
    int direction = 0; // 0: North, 1: East, 2: South, 3: West
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    for (int i = 0; i < instructionsSize; i++) {
        if (instructions[i] == 'L') {
            direction = (direction + 3) % 4;
        } else if (instructions[i] == 'R') {
            direction = (direction + 1) % 4;
        } else {
            end.x += dx[direction];
            end.y += dy[direction];
        }
    }

    if (end.x == 0 && end.y == 0) {
        return true;
    }

    return direction != 0;
}