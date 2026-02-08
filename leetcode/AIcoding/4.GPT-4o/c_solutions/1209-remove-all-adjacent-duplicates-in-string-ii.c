char *removeDuplicates(char *s, int k) {
    int len = strlen(s);
    char *stack = malloc(len + 1);
    int *count = malloc(len * sizeof(int));
    int top = 0;

    for (int i = 0; i < len; i++) {
        if (top > 0 && stack[top - 1] == s[i]) {
            count[top - 1]++;
            if (count[top - 1] == k) {
                top--;
            }
        } else {
            stack[top] = s[i];
            count[top] = 1;
            top++;
        }
    }

    stack[top] = '\0';
    free(count);

    return strdup(stack);
}