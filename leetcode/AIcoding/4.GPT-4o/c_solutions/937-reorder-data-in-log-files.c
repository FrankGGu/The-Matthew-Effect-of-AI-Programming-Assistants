#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *content;
    int isDigit;
} Log;

int compare(const void *a, const void *b) {
    Log *log1 = (Log *)a;
    Log *log2 = (Log *)b;

    if (!log1->isDigit && !log2->isDigit) {
        int cmp = strcmp(log1->content + strchr(log1->content, ' ') - log1->content, log2->content + strchr(log2->content, ' ') - log2->content);
        return cmp ? cmp : strcmp(log1->content, log2->content);
    }
    return log1->isDigit - log2->isDigit;
}

char **reorderLogs(char **logs, int logsSize, int *returnSize) {
    Log *logArray = malloc(logsSize * sizeof(Log));
    *returnSize = logsSize;

    for (int i = 0; i < logsSize; i++) {
        logArray[i].content = logs[i];
        logArray[i].isDigit = isdigit(logs[i][strchr(logs[i], ' ') - logs[i] + 1]);
    }

    qsort(logArray, logsSize, sizeof(Log), compare);

    char **result = malloc(logsSize * sizeof(char *));
    for (int i = 0; i < logsSize; i++) {
        result[i] = logArray[i].content;
    }

    free(logArray);
    return result;
}