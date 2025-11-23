#include <stdlib.h> // For qsort, calloc, malloc, free

typedef struct {
    int id;
    int time;
} LogEntry;

int compareLogEntries(const void* a, const void* b) {
    LogEntry* entryA = (LogEntry*)a;
    LogEntry* entryB = (LogEntry*)b;

    if (entryA->id != entryB->id) {
        return entryA->id - entryB->id;
    }
    return entryA->time - entryB->time;
}

int* findingUsersActiveMinutes(int** logs, int logsSize, int* logsColSize, int k, int* returnSize) {
    // Allocate memory for the result array and initialize to zeros
    int* answer = (int*)calloc(k, sizeof(int));
    *returnSize = k;

    // If there are no logs, return the zero-initialized answer array
    if (logsSize == 0) {
        return answer;
    }

    // Create a temporary array of LogEntry structs to facilitate sorting
    LogEntry* sortedLogs = (LogEntry*)malloc(logsSize * sizeof(LogEntry));
    for (int i = 0; i < logsSize; i++) {
        sortedLogs[i].id = logs[i][0];
        sortedLogs[i].time = logs[i][1];
    }

    // Sort the LogEntry array using the custom comparison function
    qsort(sortedLogs, logsSize, sizeof(LogEntry), compareLogEntries);

    // Variables to track the current user's activity
    int currentId = sortedLogs[0].id;
    int currentUAM = 0;
    // time_i values are >= 1, so -1 is a safe initial value for prevTimeForCurrentUser
    int prevTimeForCurrentUser = -1; 

    // Iterate through the sorted logs to calculate UAM for each user
    for (int i = 0; i < logsSize; i++) {
        // If the current log entry belongs to a different user, or we've reached the end
        // of the logs (handled by processing the last user after the loop)
        if (sortedLogs[i].id != currentId) {
            // If the previous user had a valid UAM, increment the corresponding count in the answer array
            if (currentUAM > 0 && currentUAM <= k) {
                answer[currentUAM - 1]++;
            }

            // Reset variables for the new user
            currentId = sortedLogs[i].id;
            currentUAM = 0;
            prevTimeForCurrentUser = -1;
        }

        // Count unique minutes for the current user
        // The problem states "time_i values are distinct for a given ID_i",
        // but the input `logs` array can contain duplicate `[ID, time]` entries.
        // We only want to count each unique minute once per user.
        if (sortedLogs[i].time != prevTimeForCurrentUser) {
            currentUAM++;
            prevTimeForCurrentUser = sortedLogs[i].time;
        }
    }

    // After the loop, process the UAM for the very last user
    if (currentUAM > 0 && currentUAM <= k) {
        answer[currentUAM - 1]++;
    }

    // Free the temporary sortedLogs array
    free(sortedLogs);

    return answer;
}