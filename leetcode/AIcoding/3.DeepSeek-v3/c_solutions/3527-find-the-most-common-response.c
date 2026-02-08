typedef struct {
    int user;
    int time;
    char response[10];
} LogEntry;

typedef struct {
    int user;
    char response[10];
} UserResponse;

int compareLog(const void* a, const void* b) {
    LogEntry* logA = (LogEntry*)a;
    LogEntry* logB = (LogEntry*)b;
    if (logA->user != logB->user) {
        return logA->user - logB->user;
    }
    return logA->time - logB->time;
}

int compareResponse(const void* a, const void* b) {
    return strcmp(((UserResponse*)a)->response, ((UserResponse*)b)->response);
}

char** mostCommonResponse(int logsSize, int** logs, int logsColSize, int* returnSize) {
    LogEntry* logEntries = (LogEntry*)malloc(logsSize * sizeof(LogEntry));
    for (int i = 0; i < logsSize; i++) {
        logEntries[i].user = logs[i][0];
        logEntries[i].time = logs[i][1];
        strcpy(logEntries[i].response, logs[i][2] == 0 ? "yes" : "no");
    }

    qsort(logEntries, logsSize, sizeof(LogEntry), compareLog);

    UserResponse* userResponses = (UserResponse*)malloc(logsSize * sizeof(UserResponse));
    int respCount = 0;

    for (int i = 0; i < logsSize; i++) {
        if (i == 0 || logEntries[i].user != logEntries[i-1].user) {
            strcpy(userResponses[respCount].response, logEntries[i].response);
            userResponses[respCount].user = logEntries[i].user;
            respCount++;
        }
    }

    qsort(userResponses, respCount, sizeof(UserResponse), compareResponse);

    int maxCount = 0;
    int currentCount = 0;
    char* mostCommon = NULL;

    for (int i = 0; i <= respCount; i++) {
        if (i > 0 && (i == respCount || strcmp(userResponses[i].response, userResponses[i-1].response) != 0)) {
            if (currentCount > maxCount) {
                maxCount = currentCount;
                mostCommon = userResponses[i-1].response;
            }
            currentCount = 1;
        } else {
            currentCount++;
        }
    }

    char** result = (char**)malloc(sizeof(char*));
    result[0] = (char*)malloc(10 * sizeof(char));
    strcpy(result[0], mostCommon);
    *returnSize = 1;

    free(logEntries);
    free(userResponses);

    return result;
}