#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x;
    int y;
    int dir;
} Robot;

typedef struct {
    int x;
    int y;
} Obstacle;

typedef struct {
    Obstacle* obstacles;
    int size;
} ObstacleList;

int compare(const void* a, const void* b) {
    return ((Obstacle*)a)->x - ((Obstacle*)b)->x;
}

void robotSimulate(int** commands, int commandsSize, int** obstacles, int obstaclesSize, int* returnSize, int** returnColumnSizes, int** result) {
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    Robot robot = {0, 0, 0};
    int maxDistance = 0;
    Point maxPoint = {0, 0};

    ObstacleList obstacleList;
    obstacleList.size = obstaclesSize;
    obstacleList.obstacles = (Obstacle*)malloc(obstaclesSize * sizeof(Obstacle));
    for (int i = 0; i < obstaclesSize; i++) {
        obstacleList.obstacles[i].x = obstacles[i][0];
        obstacleList.obstacles[i].y = obstacles[i][1];
    }

    qsort(obstacleList.obstacles, obstacleList.size, sizeof(Obstacle), compare);

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i][0] == -1) {
            robot.dir = (robot.dir + 1) % 4;
        } else if (commands[i][0] == -2) {
            robot.dir = (robot.dir + 3) % 4;
        } else {
            int steps = commands[i][0];
            int nx = robot.x;
            int ny = robot.y;
            for (int j = 0; j < steps; j++) {
                int nextX = nx + dx[robot.dir];
                int nextY = ny + dy[robot.dir];
                int found = 0;
                for (int k = 0; k < obstacleList.size; k++) {
                    if (obstacleList.obstacles[k].x == nextX && obstacleList.obstacles[k].y == nextY) {
                        found = 1;
                        break;
                    }
                }
                if (found) break;
                nx = nextX;
                ny = nextY;
            }
            robot.x = nx;
            robot.y = ny;
            int distance = robot.x * robot.x + robot.y * robot.y;
            if (distance > maxDistance) {
                maxDistance = distance;
                maxPoint.x = robot.x;
                maxPoint.y = robot.y;
            }
        }
    }

    *returnSize = 1;
    *returnColumnSizes = (int*)malloc(sizeof(int));
    (*returnColumnSizes)[0] = 2;
    *result = (int*)malloc(2 * sizeof(int));
    (*result)[0] = maxPoint.x;
    (*result)[1] = maxPoint.y;

    free(obstacleList.obstacles);
}