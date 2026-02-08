char * reverseParentheses(char * s) {
    int len = strlen(s);
    char **stack = (char **)malloc(len * sizeof(char *));
    int top = -1;
    char *result = (char *)malloc((len + 1) * sizeof(char));
    int idx = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = result + idx;
            idx = 0;
        } else if (s[i] == ')') {
            char *start = stack[top--];
            for (int j = idx - 1; j >= 0; j--) {
                *(start++) = result[j];
            }
            idx = start - result;
        } else {
            result[idx++] = s[i];
        }
    }
    result[idx] = '\0';
    free(stack);
    return result;
}