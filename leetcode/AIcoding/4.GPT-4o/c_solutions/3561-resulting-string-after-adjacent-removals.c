char *removeDuplicates(char * s) {
    int len = strlen(s);
    char *stack = malloc(len + 1);
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && stack[top] == s[i]) {
            top--;
        } else {
            stack[++top] = s[i];
        }
    }

    stack[top + 1] = '\0';
    return stack;
}