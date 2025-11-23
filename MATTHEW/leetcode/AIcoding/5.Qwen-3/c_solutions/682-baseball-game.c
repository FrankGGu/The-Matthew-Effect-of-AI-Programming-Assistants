#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* calPoints(char** operations, int operationsSize, int* returnSize) {
    int* stack = (int*)malloc(sizeof(int) * operationsSize);
    int top = -1;
    for (int i = 0; i < operationsSize; i++) {
        char* op = operations[i];
        if (strcmp(op, "C") == 0) {
            top--;
        } else if (strcmp(op, "D") == 0) {
            stack[top + 1] = stack[top] * 2;
            top++;
        } else if (strcmp(op, "F") == 0) {
            stack[top + 1] = stack[top] + stack[top - 1];
            top++;
        } else {
            stack[++top] = atoi(op);
        }
    }
    *returnSize = top + 1;
    return stack;
}