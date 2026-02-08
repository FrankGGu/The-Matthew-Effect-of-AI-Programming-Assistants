int calculate(char* s) {
    int len = strlen(s);
    int stack[len];
    int top = -1;
    int num = 0;
    char sign = '+';

    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + (s[i] - '0');
        }

        if ((!isdigit(s[i]) && s[i] != ' ') || i == len - 1) {
            if (sign == '+') {
                stack[++top] = num;
            } else if (sign == '-') {
                stack[++top] = -num;
            } else if (sign == '*') {
                stack[top] = stack[top] * num;
            } else if (sign == '/') {
                stack[top] = stack[top] / num;
            }
            sign = s[i];
            num = 0;
        }
    }

    int result = 0;
    for (int i = 0; i <= top; i++) {
        result += stack[i];
    }
    return result;
}