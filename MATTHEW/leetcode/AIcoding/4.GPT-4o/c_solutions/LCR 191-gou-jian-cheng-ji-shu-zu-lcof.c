int calPoints(char ** ops, int opsSize) {
    int stack[opsSize];
    int top = 0;
    for (int i = 0; i < opsSize; i++) {
        if (strcmp(ops[i], "C") == 0) {
            top--;
        } else if (strcmp(ops[i], "D") == 0) {
            stack[top] = stack[top - 1] * 2;
            top++;
        } else if (strcmp(ops[i], "+") == 0) {
            stack[top] = stack[top - 1] + stack[top - 2];
            top++;
        } else {
            stack[top] = atoi(ops[i]);
            top++;
        }
    }
    int sum = 0;
    for (int i = 0; i < top; i++) {
        sum += stack[i];
    }
    return sum;
}