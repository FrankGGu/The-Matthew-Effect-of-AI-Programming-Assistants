int robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    int dx[4] = {0, 1, 0, -1};
    int dy[4] = {1, 0, -1, 0};
    int x = 0, y = 0, di = 0;
    int maxDist = 0;

    int obstacleSet[obstaclesSize][2];
    for (int i = 0; i < obstaclesSize; i++) {
        obstacleSet[i][0] = obstacles[i][0];
        obstacleSet[i][1] = obstacles[i][1];
    }

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -2) {
            di = (di + 3) % 4;
        } else if (commands[i] == -1) {
            di = (di + 1) % 4;
        } else {
            for (int k = 0; k < commands[i]; k++) {
                int nx = x + dx[di];
                int ny = y + dy[di];
                int blocked = 0;
                for (int j = 0; j < obstaclesSize; j++) {
                    if (nx == obstacleSet[j][0] && ny == obstacleSet[j][1]) {
                        blocked = 1;
                        break;
                    }
                }
                if (blocked) {
                    break;
                } else {
                    x = nx;
                    y = ny;
                    int dist = x * x + y * y;
                    if (dist > maxDist) {
                        maxDist = dist;
                    }
                }
            }
        }
    }

    return maxDist;
}