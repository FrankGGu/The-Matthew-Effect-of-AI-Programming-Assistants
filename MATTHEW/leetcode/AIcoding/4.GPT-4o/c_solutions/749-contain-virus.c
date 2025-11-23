int containVirus(int** isInfected, int isInfectedSize, int* isInfectedColSize) {
    int totalWalls = 0;
    while (1) {
        int maxRegion = -1, regionIdx = -1;
        int walls[50] = {0}, regionCount[50] = {0};
        int visited[50][50] = {0};

        for (int i = 0; i < isInfectedSize; i++) {
            for (int j = 0; j < isInfectedColSize[i]; j++) {
                if (isInfected[i][j] == 1 && !visited[i][j]) {
                    int wallsInRegion = 0, count = 0;
                    int queue[2500][2], front = 0, rear = 0;
                    queue[rear][0] = i;
                    queue[rear][1] = j;
                    rear++;
                    visited[i][j] = 1;

                    while (front < rear) {
                        int x = queue[front][0];
                        int y = queue[front][1];
                        front++;
                        count++;

                        for (int d = -1; d <= 1; d += 2) {
                            if (x + d >= 0 && x + d < isInfectedSize && !visited[x + d][y] && isInfected[x + d][y] == 0) {
                                wallsInRegion++;
                            }
                            if (y + d >= 0 && y + d < isInfectedColSize[x] && !visited[x][y + d] && isInfected[x][y + d] == 0) {
                                wallsInRegion++;
                            }
                        }

                        for (int d = -1; d <= 1; d++) {
                            for (int e = -1; e <= 1; e++) {
                                if (abs(d) + abs(e) == 1) {
                                    int nx = x + d, ny = y + e;
                                    if (nx >= 0 && nx < isInfectedSize && ny >= 0 && ny < isInfectedColSize[nx] && !visited[nx][ny] && isInfected[nx][ny] == 1) {
                                        visited[nx][ny] = 1;
                                        queue[rear][0] = nx;
                                        queue[rear][1] = ny;
                                        rear++;
                                    }
                                }
                            }
                        }
                    }
                    regionCount[regionIdx + 1] = count;
                    walls[regionIdx + 1] = wallsInRegion;
                    regionIdx++;
                    if (count > maxRegion) {
                        maxRegion = count;
                    }
                }
            }
        }

        int maxWalls = 0;
        for (int i = 0; i <= regionIdx; i++) {
            if (walls[i] > maxWalls) {
                maxWalls = walls[i];
            }
        }
        totalWalls += maxWalls;

        for (int i = 0; i <= regionIdx; i++) {
            if (walls[i] == maxWalls) {
                for (int j = 0; j < isInfectedSize; j++) {
                    for (int k = 0; k < isInfectedColSize[j]; k++) {
                        if (isInfected[j][k] == 1) {
                            isInfected[j][k] = -1;
                        }
                    }
                }
                break;
            }
        }

        int hasNewInfection = 0;
        for (int i = 0; i < isInfectedSize; i++) {
            for (int j = 0; j < isInfectedColSize[i]; j++) {
                if (isInfected[i][j] == 1) {
                    for (int d = -1; d <= 1; d += 2) {
                        if (i + d >= 0 && i + d < isInfectedSize && isInfected[i + d][j] == 0) {
                            isInfected[i + d][j] = 1;
                            hasNewInfection = 1;
                        }
                        if (j + d >= 0 && j + d < isInfectedColSize[i] && isInfected[i][j + d] == 0) {
                            isInfected[i][j + d] = 1;
                            hasNewInfection = 1;
                        }
                    }
                }
            }
        }

        if (!hasNewInfection) {
            break;
        }
    }
    return totalWalls;
}