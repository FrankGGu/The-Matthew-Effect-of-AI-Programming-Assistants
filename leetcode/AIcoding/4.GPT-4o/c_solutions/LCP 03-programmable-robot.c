bool robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int x = 0, y = 0, dir = 0;
    bool obstacleMap[10001][10001] = {false};

    for (int i = 0; i < obstaclesSize; i++) {
        obstacleMap[obstacles[i][0] + 5000][obstacles[i][1] + 5000] = true;
    }

    for (int i = 0; i < commandsSize; i++) {
        if (commands[i] == -2) {
            dir = (dir + 3) % 4;
        } else if (commands[i] == -1) {
            dir = (dir + 1) % 4;
        } else {
            for (int j = 0; j < commands[i]; j++) {
                if (!obstacleMap[x + dx[dir]][y + dy[dir]]) {
                    x += dx[dir];
                    y += dy[dir];
                }
            }
        }
    }

    return x * x + y * y;
}