int minimumFinishTime(int** tires, int tiresSize, int* tiresColSize, int changeTime, int numLaps) {
    int* minTime = (int*)malloc((numLaps + 1) * sizeof(int));
    for (int i = 0; i <= numLaps; i++) {
        minTime[i] = INT_MAX;
    }

    for (int i = 0; i < tiresSize; i++) {
        int f = tires[i][0];
        int r = tires[i][1];
        int time = 0;
        for (int lap = 1; lap <= numLaps; lap++) {
            int currentLapTime = f * (int)pow(r, lap - 1);
            if (currentLapTime > changeTime + f) {
                break;
            }
            time += currentLapTime;
            if (time < minTime[lap]) {
                minTime[lap] = time;
            }
        }
    }

    int* dp = (int*)malloc((numLaps + 1) * sizeof(int));
    for (int i = 0; i <= numLaps; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= numLaps; i++) {
        for (int j = 1; j <= i; j++) {
            if (minTime[j] == INT_MAX) continue;
            int prev = dp[i - j];
            if (prev == INT_MAX) continue;
            int total = prev + changeTime + minTime[j];
            if (total < dp[i]) {
                dp[i] = total;
            }
        }
    }

    int result = dp[numLaps] - changeTime;
    free(minTime);
    free(dp);
    return result;
}