#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *id;
    char *log;
} LogEntry;

int compare(const void *a, const void *b) {
    LogEntry *logA = (LogEntry *)a;
    LogEntry *logB = (LogEntry *)b;
    int cmp = strcmp(logA->log, logB->log);
    if (cmp != 0) return cmp;
    return strcmp(logA->id, logB->id);
}

char **reorderLogFiles(char **logs, int logsSize, int *returnSize) {
    LogEntry *entries = (LogEntry *)malloc(logsSize * sizeof(LogEntry));
    int letterCount = 0;
    int digitCount = 0;

    for (int i = 0; i < logsSize; i++) {
        char *log = logs[i];
        char *space = strchr(log, ' ');
        if (space && *(space + 1) >= 'a' && *(space + 1) <= 'z') {
            entries[letterCount].id = strndup(log, space - log);
            entries[letterCount].log = strdup(space + 1);
            letterCount++;
        } else {
            digitCount++;
        }
    }

    qsort(entries, letterCount, sizeof(LogEntry), compare);

    char **result = (char **)malloc((logsSize) * sizeof(char *));
    int index = 0;

    for (int i = 0; i < letterCount; i++) {
        char *newLog = (char *)malloc(strlen(entries[i].id) + strlen(entries[i].log) + 2);
        sprintf(newLog, "%s %s", entries[i].id, entries[i].log);
        result[index++] = newLog;
    }

    for (int i = 0; i < logsSize; i++) {
        if (strchr(logs[i], ' ') && *(strchr(logs[i], ' ') + 1) >= '0' && *(strchr(logs[i], ' ') + 1) <= '9') {
            result[index++] = logs[i];
        }
    }

    *returnSize = logsSize;
    free(entries);
    return result;
}