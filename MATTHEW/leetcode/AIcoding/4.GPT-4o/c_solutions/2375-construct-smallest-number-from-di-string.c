char *smallestNumber(char *pattern) {
    int n = strlen(pattern);
    int stack[n + 2], top = 0;
    char *result = (char *)malloc((n + 2) * sizeof(char));
    int num = 1;

    for (int i = 0; i <= n; i++) {
        stack[top++] = num++;
        if (i == n || pattern[i] == 'I') {
            while (top > 0) {
                result[i - top + 1] = '0' + stack[--top];
            }
        }
    }
    result[n + 1] = '\0';
    return result;
}