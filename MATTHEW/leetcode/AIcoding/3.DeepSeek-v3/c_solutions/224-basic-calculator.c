int calculate(char* s) {
    int len = strlen(s);
    int* stack = (int*)malloc(len * sizeof(int));
    int top = -1;
    int result = 0;
    int num = 0;
    int sign = 1;

    for (int i = 0; i < len; i++) {
        char c = s[i];
        if (c >= '0' && c <= '9') {
            num = num * 10 + (c - '0');
        } else if (c == '+') {
            result += sign * num;
            num = 0;
            sign = 1;
        } else if (c == '-') {
            result += sign * num;
            num = 0;
            sign = -1;
        } else if (c == '(') {
            stack[++top] = result;
            stack[++top] = sign;
            result = 0;
            sign = 1;
        } else if (c == ')') {
            result += sign * num;
            num = 0;
            result *= stack[top--];
            result += stack[top--];
        }
    }

    if (num != 0) {
        result += sign * num;
    }

    free(stack);
    return result;
}