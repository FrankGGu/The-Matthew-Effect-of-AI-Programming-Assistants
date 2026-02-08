#include <stdio.h>
#include <stdlib.h>

int* exclusiveTime(int n, char **logs, int logsSize, int* returnSize) {
    int *result = (int *)calloc(n, sizeof(int));
    int *stack = (int *)malloc(logsSize * sizeof(int));
    int top = -1;
    int prevTime = 0;

    for (int i = 0; i < logsSize; i++) {
        char *log = logs[i];
        int id = 0, time = 0;
        while (*log != ':') {
            id = id * 10 + (*log - '0');
            log++;
        }
        log++; // Skip ':'
        int isStart = (*log == 's');
        log += 2; // Skip 's ' or 'e '
        while (*log != '\0') {
            time = time * 10 + (*log - '0');
            log++;
        }

        if (top != -1) {
            result[stack[top]] += time - prevTime;
        }
        prevTime = time;

        if (isStart) {
            stack[++top] = id;
            prevTime = time;
        } else {
            result[stack[top]] += time - prevTime + 1;
            top--;
            prevTime = time + 1;
        }
    }

    free(stack);
    *returnSize = n;
    return result;
}