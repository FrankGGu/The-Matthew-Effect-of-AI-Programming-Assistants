#include <stdlib.h>
#include <string.h>

int stack[10001];
int top = -1;

void push(int val) {
    stack[++top] = val;
}

int pop() {
    return stack[top--];
}

int evalRPN(char **tokens, int tokensSize) {
    top = -1;

    for (int i = 0; i < tokensSize; i++) {
        char *token = tokens[i];

        if (strlen(token) == 1 && (token[0] == '+' || token[0] == '-' || token[0] == '*' || token[0] == '/')) {
            int operand2 = pop();
            int operand1 = pop();
            int result;

            switch (token[0]) {
                case '+':
                    result = operand1 + operand2;
                    break;
                case '-':
                    result = operand1 - operand2;
                    break;
                case '*':
                    result = operand1 * operand2;
                    break;
                case '/':
                    result = operand1 / operand2;
                    break;
            }
            push(result);
        } else {
            push(atoi(token));
        }
    }
    return pop();
}