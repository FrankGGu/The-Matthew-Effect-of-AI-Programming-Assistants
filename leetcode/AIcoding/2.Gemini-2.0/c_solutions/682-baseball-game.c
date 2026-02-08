#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calPoints(char ** operations, int operationsSize){
    int *stack = (int *)malloc(sizeof(int) * operationsSize);
    int top = -1;
    int sum = 0;

    for (int i = 0; i < operationsSize; i++) {
        if (strcmp(operations[i], "+") == 0) {
            stack[top + 1] = stack[top] + stack[top - 1];
            top++;
        } else if (strcmp(operations[i], "D") == 0) {
            stack[top + 1] = stack[top] * 2;
            top++;
        } else if (strcmp(operations[i], "C") == 0) {
            top--;
        } else {
            stack[top + 1] = atoi(operations[i]);
            top++;
        }
    }

    for (int i = 0; i <= top; i++) {
        sum += stack[i];
    }

    free(stack);
    return sum;
}