char *removeDuplicates(char *s) {
    int len = 0;
    char *stack = malloc(strlen(s) + 1);

    for (int i = 0; s[i] != '\0'; i++) {
        if (len > 0 && stack[len - 1] == s[i]) {
            len--;
        } else {
            stack[len++] = s[i];
        }
    }
    stack[len] = '\0';

    return stack;
}