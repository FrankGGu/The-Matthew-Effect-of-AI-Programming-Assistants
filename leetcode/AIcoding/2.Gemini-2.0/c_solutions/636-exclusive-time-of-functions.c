#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* exclusiveTime(int n, char ** logs, int logsSize, int* returnSize){
    int *result = (int*)malloc(n * sizeof(int));
    memset(result, 0, n * sizeof(int));

    int *stack = (int*)malloc(logsSize * sizeof(int));
    int top = -1;

    int prevTime = 0;

    for (int i = 0; i < logsSize; i++) {
        int id;
        char type[6];
        int time;
        sscanf(logs[i], "%d:%[^:]:%d", &id, type, &time);

        if (strcmp(type, "start") == 0) {
            if (top != -1) {
                result[stack[top]] += time - prevTime;
            }
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