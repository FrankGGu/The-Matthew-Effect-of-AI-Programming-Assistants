char* minRemoveToMakeValid(char* s) {
    int len = strlen(s);
    int* stack = malloc(len * sizeof(int));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else if (s[i] == ')') {
            if (top >= 0 && s[stack[top]] == '(') {
                top--;
            } else {
                stack[++top] = i;
            }
        }
    }

    int* remove = calloc(len, sizeof(int));
    for (int i = 0; i <= top; i++) {
        remove[stack[i]] = 1;
    }

    char* result = malloc(len + 1);
    int j = 0;
    for (int i = 0; i < len; i++) {
        if (!remove[i]) {
            result[j++] = s[i];
        }
    }
    result[j] = '\0';

    free(stack);
    free(remove);
    return result;
}