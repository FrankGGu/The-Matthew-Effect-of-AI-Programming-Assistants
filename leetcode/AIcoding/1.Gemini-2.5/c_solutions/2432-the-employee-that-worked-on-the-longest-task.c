int hardestWorker(int n, int** logs, int logsSize, int* logsColSize) {
    int maxDuration = logs[0][1];
    int resultEmployeeId = logs[0][0];
    int previousFinishTime = logs[0][1];

    for (int i = 1; i < logsSize; i++) {
        int currentEmployeeId = logs[i][0];
        int currentFinishTime = logs[i][1];
        int currentDuration = currentFinishTime - previousFinishTime;

        if (currentDuration > maxDuration) {
            maxDuration = currentDuration;
            resultEmployeeId = currentEmployeeId;
        } else if (currentDuration == maxDuration) {
            if (currentEmployeeId < resultEmployeeId) {
                resultEmployeeId = currentEmployeeId;
            }
        }
        previousFinishTime = currentFinishTime;
    }

    return resultEmployeeId;
}