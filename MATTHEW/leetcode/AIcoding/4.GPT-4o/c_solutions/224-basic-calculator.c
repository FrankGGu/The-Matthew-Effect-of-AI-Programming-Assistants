int calculate(char * s) {
    int len = strlen(s);
    int stack[len], top = -1, num = 0, sign = 1;
    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + (s[i] - '0');
        } else if (s[i] == '+') {
            stack[++top] = sign * num;
            num = 0;
            sign = 1;
        } else if (s[i] == '-') {
            stack[++top] = sign * num;
            num = 0;
            sign = -1;
        } else if (s[i] == '(') {
            stack[++top] = sign;
            stack[++top] = -1; // marker for start of a new expression
            sign = 1;
        } else if (s[i] == ')') {
            stack[++top] = sign * num;
            num = 0;
            int sum = 0;
            while (stack[top] != -1) {
                sum += stack[top--];
            }
            top--; // pop the sign
            sign = stack[top--];
            num = sum;
        }
    }
    stack[++top] = sign * num;
    int result = 0;
    while (top >= 0) {
        result += stack[top--];
    }
    return result;
}