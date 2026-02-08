int hardestWorker(int n, int** logs, int logsSize, int* logsColSize) {
    int maxId = logs[0][0];
    int maxTime = logs[0][1];
    int prevTime = 0;

    for (int i = 0; i < logsSize; i++) {
        int currentTime = logs[i][1] - prevTime;
        if (currentTime > maxTime || (currentTime == maxTime && logs[i][0] < maxId)) {
            maxTime = currentTime;
            maxId = logs[i][0];
        }
        prevTime = logs[i][1];
    }

    return maxId;
}