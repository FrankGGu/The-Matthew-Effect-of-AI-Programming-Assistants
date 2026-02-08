#include <stdlib.h> // Required for atoi

int calPoints(char ** operations, int operationsSize) {
    int scores[operationsSize];
    int top = 0;

    for (int i = 0; i < operationsSize; i++) {
        char *op = operations[i];

        if (op[0] == '+') {
            scores[top] = scores[top - 1] + scores[top - 2];
            top++;
        } else if (op[0] == 'D') {
            scores[top] = 2 * scores[top - 1];
            top++;
        } else if (op[0] == 'C') {
            top--;
        } else {
            scores[top] = atoi(op);
            top++;
        }
    }

    int totalSum = 0;
    for (int i = 0; i < top; i++) {
        totalSum += scores[i];
    }

    return totalSum;
}