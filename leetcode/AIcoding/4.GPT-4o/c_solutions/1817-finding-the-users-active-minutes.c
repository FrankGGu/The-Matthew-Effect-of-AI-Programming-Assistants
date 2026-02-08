int* findingUsersActiveMinutes(int** logs, int logsSize, int k, int* returnSize) {
    int* activeMinutes = (int*)calloc(k, sizeof(int));
    int* userUAM = (int*)calloc(100001, sizeof(int));
    int* userSeen = (int*)calloc(100001, sizeof(int));

    for (int i = 0; i < logsSize; i++) {
        int userId = logs[i][0];
        int minute = logs[i][1];
        if (!userSeen[userId]) {
            userSeen[userId] = 1;
            userUAM[userId] = 1;
        } else {
            if (userUAM[userId] == 0 || userUAM[userId] < minute) {
                userUAM[userId]++;
            }
        }
    }

    for (int i = 0; i < 100001; i++) {
        if (userUAM[i] > 0) {
            activeMinutes[userUAM[i] - 1]++;
        }
    }

    *returnSize = k;
    free(userUAM);
    free(userSeen);

    return activeMinutes;
}