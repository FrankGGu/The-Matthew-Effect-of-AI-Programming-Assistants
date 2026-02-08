int hardestWorker(int n, int** logs, int logsSize, int* logsColSize) {
    int maxTime = logs[0][1];
    int result = logs[0][0];

    for (int i = 1; i < logsSize; i++) {
        int time = logs[i][1] - logs[i-1][1];
        if (time > maxTime) {
            maxTime = time;
            result = logs[i][0];
        } else if (time == maxTime) {
            if (logs[i][0] < result) {
                result = logs[i][0];
            }
        }
    }

    return result;
}