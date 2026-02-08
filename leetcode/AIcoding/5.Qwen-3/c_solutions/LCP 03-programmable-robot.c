#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point pos;
    int steps;
} State;

int** robotSimulate(int** commands, int commandsSize, int* obstacles, int obstaclesSize, int* returnSize, int** returnColumnSizes) {
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int maxDist = 0;
    Point pos = {0, 0};
    int dir = 0;

    int obstacleSetSize = obstaclesSize / 2;
    char** obstacleSet = (char**)malloc(obstacleSetSize * sizeof(char*));
    for (int i = 0; i < obstacleSetSize; i++) {
        obstacleSet[i] = (char*)malloc(2 * sizeof(char));
        sprintf(obstacleSet[i], "%d,%d", obstacles[2*i], obstacles[2*i+1]);
    }

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -1) {
            dir = (dir + 1) % 4;
        } else if (commands[i] == -2) {
            dir = (dir + 3) % 4;
        } else {
            for (int j = 0; j < commands[i]; j++) {
                int newX = pos.x + dx[dir];
                int newY = pos.y + dy[dir];
                char key[20];
                sprintf(key, "%d,%d", newX, newY);
                int found = 0;
                for (int k = 0; k < obstacleSetSize; k++) {
                    if (strcmp(obstacleSet[k], key) == 0) {
                        found = 1;
                        break;
                    }
                }
                if (found) break;
                pos.x = newX;
                pos.y = newY;
            }
        }
        int dist = pos.x * pos.x + pos.y * pos.y;
        if (dist > maxDist) {
            maxDist = dist;
        }
    }

    *returnSize = 1;
    *returnColumnSizes = (int*)malloc(sizeof(int));
    (*returnColumnSizes)[0] = 2;
    int** result = (int**)malloc(sizeof(int*));
    result[0] = (int*)malloc(2 * sizeof(int));
    result[0][0] = pos.x;
    result[0][1] = pos.y;

    for (int i = 0; i < obstacleSetSize; i++) {
        free(obstacleSet[i]);
    }
    free(obstacleSet);

    return result;
}