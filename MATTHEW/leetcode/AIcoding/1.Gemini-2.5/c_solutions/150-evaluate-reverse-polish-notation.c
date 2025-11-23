#include <stdlib.h> // For atoi
#include <string.h> // For strcmp

#define MAX_STACK_SIZE 10000

int evalRPN(char **tokens, int tokensSize) {
    int stack[MAX_STACK_SIZE];
    int top = -1; // Stack is empty

    for (int i = 0; i < tokensSize; i++) {
        char *token = tokens[i];

        if (strcmp(token, "+") == 0) {
            int op2 = stack[top--];
            int op1 = stack[top--];
            stack[++top] = op1 + op2;
        } else if (strcmp(token, "-") == 0) {
            int op2 = stack[top--];
            int op1 = stack[top--];
            stack[++top] = op1 - op2;
        } else if (strcmp(token, "*") == 0) {
            int op2 = stack[top--];
            int op1 = stack[top--];
            stack[++top] = op1 * op2;
        } else if (strcmp(token, "/") == 0) {
            int op2 = stack[top--];
            int op1 = stack[top--];
            stack[++top] = op1 / op2;
        } else {
            // It's a number
            stack[++top] = atoi(token);
        }
    }

    return stack[top];
}