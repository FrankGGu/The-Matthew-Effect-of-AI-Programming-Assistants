#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int robotSim(int* distance, int distanceSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    int x = 0, y = 0;
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int dir = 0;
    int maxDist = 0;

    for (int i = 0; i < distanceSize; i++) {
        int steps = distance[i];
        for (int j = 0; j < steps; j++) {
            int nx = x + dx[dir];
            int ny = y + dy[dir];
            int collision = 0;
            for (int k = 0; k < obstaclesSize; k++) {
                if (obstacles[k][0] == nx && obstacles[k][1] == ny) {
                    collision = 1;
                    break;
                }
            }
            if (collision) break;
            x = nx;
            y = ny;
            maxDist = fmax(maxDist, x * x + y * y);
        }
        dir = (dir + 1) % 4;
    }
    return maxDist;
}