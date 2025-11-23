#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int evalRPN(char** tokens, int tokensSize) {
    int stack[tokensSize];
    int top = -1;

    for (int i = 0; i < tokensSize; i++) {
        if (strcmp(tokens[i], "+") == 0) {
            int operand2 = stack[top--];
            int operand1 = stack[top--];
            stack[++top] = operand1 + operand2;
        } else if (strcmp(tokens[i], "-") == 0) {
            int operand2 = stack[top--];
            int operand1 = stack[top--];
            stack[++top] = operand1 - operand2;
        } else if (strcmp(tokens[i], "*") == 0) {
            int operand2 = stack[top--];
            int operand1 = stack[top--];
            stack[++top] = operand1 * operand2;
        } else if (strcmp(tokens[i], "/") == 0) {
            int operand2 = stack[top--];
            int operand1 = stack[top--];
            stack[++top] = operand1 / operand2;
        } else {
            stack[++top] = atoi(tokens[i]);
        }
    }

    return stack[top];
}