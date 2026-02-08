char * robotWithString(char * s) {
    int n = strlen(s);
    char *result = malloc(n + 1);
    int *count = (int *)calloc(26, sizeof(int));
    char *stack = malloc(n + 1);
    int top = 0;

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < n; i++) {
        stack[top++] = s[i];
        count[s[i] - 'a']--;

        while (top > 0) {
            int j = 0;
            while (j < 26 && count[j] == 0) j++;
            if (stack[top - 1] <= 'a' + j) {
                result[strlen(result)] = stack[--top];
            } else {
                break;
            }
        }
    }

    result[n] = '\0';
    free(count);
    free(stack);
    return result;
}