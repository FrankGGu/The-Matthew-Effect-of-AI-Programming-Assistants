/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countServers(int n, int** logs, int logsSize, int* logsColSize, int x, int* queries, int queriesSize, int* returnSize) {
    int* result = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    // Sort logs by time
    for (int i = 0; i < logsSize - 1; i++) {
        for (int j = 0; j < logsSize - i - 1; j++) {
            if (logs[j][1] > logs[j + 1][1]) {
                int* temp = logs[j];
                logs[j] = logs[j + 1];
                logs[j + 1] = temp;
            }
        }
    }

    // Create array for queries with indices
    int** queriesWithIndex = malloc(queriesSize * sizeof(int*));
    for (int i = 0; i < queriesSize; i++) {
        queriesWithIndex[i] = malloc(2 * sizeof(int));
        queriesWithIndex[i][0] = queries[i];
        queriesWithIndex[i][1] = i;
    }

    // Sort queries by time
    for (int i = 0; i < queriesSize - 1; i++) {
        for (int j = 0; j < queriesSize - i - 1; j++) {
            if (queriesWithIndex[j][0] > queriesWithIndex[j + 1][0]) {
                int* temp = queriesWithIndex[j];
                queriesWithIndex[j] = queriesWithIndex[j + 1];
                queriesWithIndex[j + 1] = temp;
            }
        }
    }

    int left = 0, right = 0;
    int* serverCount = calloc(n + 1, sizeof(int));
    int activeServers = 0;

    for (int i = 0; i < queriesSize; i++) {
        int queryTime = queriesWithIndex[i][0];
        int startTime = queryTime - x;
        int endTime = queryTime;

        // Move right pointer to include logs with time <= endTime
        while (right < logsSize && logs[right][1] <= endTime) {
            int serverId = logs[right][0];
            if (serverCount[serverId] == 0) {
                activeServers++;
            }
            serverCount[serverId]++;
            right++;
        }

        // Move left pointer to exclude logs with time < startTime
        while (left < logsSize && logs[left][1] < startTime) {
            int serverId = logs[left][0];
            serverCount[serverId]--;
            if (serverCount[serverId] == 0) {
                activeServers--;
            }
            left++;
        }

        result[queriesWithIndex[i][1]] = n - activeServers;
    }

    // Clean up
    for (int i = 0; i < queriesSize; i++) {
        free(queriesWithIndex[i]);
    }
    free(queriesWithIndex);
    free(serverCount);

    return result;
}