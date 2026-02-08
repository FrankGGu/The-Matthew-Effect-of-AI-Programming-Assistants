#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int evalRPN(char ** tokens, int tokensSize) {
    int *stack = (int *)malloc(tokensSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < tokensSize; i++) {
        if (isdigit(tokens[i][0]) || (tokens[i][0] == '-' && tokens[i][1] != '\0')) {
            stack[++top] = atoi(tokens[i]);
        } else {
            int b = stack[top--];
            int a = stack[top--];
            switch (tokens[i][0]) {
                case '+': stack[++top] = a + b; break;
                case '-': stack[++top] = a - b; break;
                case '*': stack[++top] = a * b; break;
                case '/': stack[++top] = a / b; break;
            }
        }
    }

    int result = stack[top];
    free(stack);
    return result;
}