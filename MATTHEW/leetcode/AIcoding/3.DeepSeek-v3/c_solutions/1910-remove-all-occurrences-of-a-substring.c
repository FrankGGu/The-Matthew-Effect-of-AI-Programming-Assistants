char* removeOccurrences(char* s, char* part) {
    int n = strlen(s);
    int m = strlen(part);
    char* stack = malloc(n + 1);
    int top = 0;

    for (int i = 0; i < n; i++) {
        stack[top++] = s[i];

        if (top >= m) {
            int match = 1;
            for (int j = 0; j < m; j++) {
                if (stack[top - m + j] != part[j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                top -= m;
            }
        }
    }

    stack[top] = '\0';
    return stack;
}