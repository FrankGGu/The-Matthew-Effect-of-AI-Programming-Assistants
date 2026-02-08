char* robotWithString(char* s) {
    int n = strlen(s);
    char* res = malloc(n + 1);
    res[n] = '\0';

    char* minAfter = malloc(n + 1);
    minAfter[n] = '\0';
    minAfter[n - 1] = s[n - 1];

    for (int i = n - 2; i >= 0; i--) {
        minAfter[i] = s[i] < minAfter[i + 1] ? s[i] : minAfter[i + 1];
    }

    char* stack = malloc(n + 1);
    int top = -1;
    int idx = 0;

    for (int i = 0; i < n; i++) {
        while (top >= 0 && stack[top] <= minAfter[i]) {
            res[idx++] = stack[top--];
        }
        stack[++top] = s[i];
    }

    while (top >= 0) {
        res[idx++] = stack[top--];
    }

    free(minAfter);
    free(stack);
    return res;
}