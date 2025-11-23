#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_OBSTACLES 10000

int robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    int x = 0, y = 0, dir = 0;
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int max_dist_sq = 0;

    int obstacle_map[MAX_OBSTACLES][2];
    int num_obstacles = 0;

    for (int i = 0; i < obstaclesSize; i++) {
        obstacle_map[num_obstacles][0] = obstacles[i][0];
        obstacle_map[num_obstacles][1] = obstacles[i][1];
        num_obstacles++;
    }

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -2) {
            dir = (dir + 3) % 4;
        } else if (commands[i] == -1) {
            dir = (dir + 1) % 4;
        } else {
            for (int j = 0; j < commands[i]; j++) {
                int next_x = x + dx[dir];
                int next_y = y + dy[dir];

                int obstacle_found = 0;
                for (int k = 0; k < num_obstacles; k++) {
                    if (obstacle_map[k][0] == next_x && obstacle_map[k][1] == next_y) {
                        obstacle_found = 1;
                        break;
                    }
                }

                if (obstacle_found) {
                    break;
                } else {
                    x = next_x;
                    y = next_y;
                    int dist_sq = x * x + y * y;
                    if (dist_sq > max_dist_sq) {
                        max_dist_sq = dist_sq;
                    }
                }
            }
        }
    }

    return max_dist_sq;
}