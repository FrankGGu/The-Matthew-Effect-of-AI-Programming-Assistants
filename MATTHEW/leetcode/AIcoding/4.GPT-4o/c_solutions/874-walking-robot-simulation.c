int robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    int x = 0, y = 0, dir = 0;
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int obstacleSet[10000][2] = {0};
    for (int i = 0; i < obstaclesSize; i++) {
        int ox = obstacles[i][0] + 3000;
        int oy = obstacles[i][1] + 3000;
        obstacleSet[ox][oy] = 1;
    }
    int maxDistance = 0;
    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -2) {
            dir = (dir + 3) % 4;
        } else if (commands[i] == -1) {
            dir = (dir + 1) % 4;
        } else {
            for (int j = 0; j < commands[i]; j++) {
                if (!obstacleSet[x + dx[dir]][y + dy[dir]]) {
                    x += dx[dir];
                    y += dy[dir];
                    maxDistance = maxDistance > (x * x + y * y) ? maxDistance : (x * x + y * y);
                } else {
                    break;
                }
            }
        }
    }
    return maxDistance;
}