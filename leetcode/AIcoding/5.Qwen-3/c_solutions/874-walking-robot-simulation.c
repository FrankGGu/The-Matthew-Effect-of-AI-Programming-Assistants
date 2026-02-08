#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x;
    int y;
    int dir;
} Robot;

int* robotSim(int* operations, int operationsSize, int* obstacles, int obstaclesSize, int* returnSize) {
    int dirs[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // up, right, down, left
    int max_x = 0, max_y = 0;
    int current_x = 0, current_y = 0;
    int direction = 0;

    int* result = (int*)malloc(2 * sizeof(int));

    // Create a hash set for obstacles
    int obstacle_set_size = obstaclesSize / 2;
    Point* obstacle_set = (Point*)malloc(obstacle_set_size * sizeof(Point));
    for (int i = 0; i < obstacle_set_size; i++) {
        obstacle_set[i].x = obstacles[2 * i];
        obstacle_set[i].y = obstacles[2 * i + 1];
    }

    for (int i = 0; i < operationsSize; i++) {
        if (operations[i] == -1) {
            direction = (direction + 1) % 4;
        } else if (operations[i] == -2) {
            direction = (direction + 3) % 4;
        } else {
            int steps = operations[i];
            for (int j = 0; j < steps; j++) {
                int next_x = current_x + dirs[direction][0];
                int next_y = current_y + dirs[direction][1];

                int blocked = 0;
                for (int k = 0; k < obstacle_set_size; k++) {
                    if (next_x == obstacle_set[k].x && next_y == obstacle_set[k].y) {
                        blocked = 1;
                        break;
                    }
                }

                if (blocked) break;

                current_x = next_x;
                current_y = next_y;

                if (abs(current_x) > max_x) max_x = abs(current_x);
                if (abs(current_y) > max_y) max_y = abs(current_y);
            }
        }
    }

    result[0] = max_x;
    result[1] = max_y;
    *returnSize = 2;

    free(obstacle_set);
    return result;
}