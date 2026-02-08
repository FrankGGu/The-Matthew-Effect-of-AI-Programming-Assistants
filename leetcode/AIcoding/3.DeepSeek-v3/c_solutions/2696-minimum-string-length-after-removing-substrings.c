int minLength(char* s) {
    int len = strlen(s);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0) {
            if ((stack[top] == 'A' && s[i] == 'B') || (stack[top] == 'C' && s[i] == 'D')) {
                top--;
                continue;
            }
        }
        stack[++top] = s[i];
    }

    free(stack);
    return top + 1;
}