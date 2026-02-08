char *removeDuplicates(char * s){
    int n = strlen(s);
    char *stack = malloc(n + 1);
    int top = 0;

    for (int i = 0; i < n; i++) {
        if (top > 0 && stack[top - 1] == s[i]) {
            top--;
        } else {
            stack[top++] = s[i];
        }
    }

    stack[top] = '\0';
    return stack;
}