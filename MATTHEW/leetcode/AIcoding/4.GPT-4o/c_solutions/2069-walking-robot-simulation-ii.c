typedef struct {
    int x;
    int y;
    int dir;
} Robot;

Robot* robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize, int* returnSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int obstacleSet[10000][2];
    for (int i = 0; i < obstaclesSize; i++) {
        obstacleSet[i][0] = obstacles[i][0] + 3000;
        obstacleSet[i][1] = obstacles[i][1] + 3000;
    }

    int maxX = 0, maxY = 0;
    Robot* robot = (Robot*)malloc(sizeof(Robot));
    robot->x = 0;
    robot->y = 0;
    robot->dir = 0;

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -2) {
            robot->dir = (robot->dir + 3) % 4;
        } else if (commands[i] == -1) {
            robot->dir = (robot->dir + 1) % 4;
        } else {
            for (int j = 0; j < commands[i]; j++) {
                int nextX = robot->x + directions[robot->dir][0];
                int nextY = robot->y + directions[robot->dir][1];
                if (nextX < -3000 || nextX > 3000 || nextY < -3000 || nextY > 3000) continue;

                int blocked = 0;
                for (int k = 0; k < obstaclesSize; k++) {
                    if (nextX == obstacleSet[k][0] && nextY == obstacleSet[k][1]) {
                        blocked = 1;
                        break;
                    }
                }
                if (blocked) break;

                robot->x = nextX;
                robot->y = nextY;
                maxX = fmax(maxX, robot->x);
                maxY = fmax(maxY, robot->y);
            }
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = robot->x;
    result[1] = robot->y;
    *returnSize = 2;
    free(robot);
    return result;
}