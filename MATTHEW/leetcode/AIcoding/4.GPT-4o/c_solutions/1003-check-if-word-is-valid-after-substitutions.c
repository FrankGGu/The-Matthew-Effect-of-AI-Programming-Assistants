bool isValid(const char *s) {
    int len = strlen(s);
    char stack[len + 1];
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == 'c') {
            if (top >= 1 && stack[top] == 'b' && stack[top - 1] == 'a') {
                top -= 2;
            } else {
                stack[++top] = s[i];
            }
        } else {
            stack[++top] = s[i];
        }
    }

    return top == -1;
}