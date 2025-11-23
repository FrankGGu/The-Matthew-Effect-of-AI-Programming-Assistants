/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findingUsersActiveMinutes(int** logs, int logsSize, int* logsColSize, int k, int* returnSize) {
    int *result = (int*)calloc(k, sizeof(int));
    *returnSize = k;

    // Sort logs by ID then by time
    for (int i = 0; i < logsSize - 1; i++) {
        for (int j = 0; j < logsSize - i - 1; j++) {
            if (logs[j][0] > logs[j+1][0] || 
                (logs[j][0] == logs[j+1][0] && logs[j][1] > logs[j+1][1])) {
                int* temp = logs[j];
                logs[j] = logs[j+1];
                logs[j+1] = temp;
            }
        }
    }

    int currentId = -1;
    int uam = 0;

    for (int i = 0; i < logsSize; i++) {
        if (logs[i][0] != currentId) {
            if (currentId != -1 && uam > 0 && uam <= k) {
                result[uam - 1]++;
            }
            currentId = logs[i][0];
            uam = 1;
        } else {
            if (logs[i][1] != logs[i-1][1]) {
                uam++;
            }
        }
    }

    if (currentId != -1 && uam > 0 && uam <= k) {
        result[uam - 1]++;
    }

    return result;
}