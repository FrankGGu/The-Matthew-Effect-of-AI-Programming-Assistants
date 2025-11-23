int longestValidParentheses(char* s) {
    int maxLen = 0;
    int len = strlen(s);
    int* stack = (int*)malloc((len + 1) * sizeof(int));
    int top = -1;

    stack[++top] = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else {
            top--;
            if (top == -1) {
                stack[++top] = i;
            } else {
                int currentLen = i - stack[top];
                if (currentLen > maxLen) {
                    maxLen = currentLen;
                }
            }
        }
    }

    free(stack);
    return maxLen;
}