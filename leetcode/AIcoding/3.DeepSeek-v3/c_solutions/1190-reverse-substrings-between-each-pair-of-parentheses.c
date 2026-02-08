char* reverse(char* s, int start, int end) {
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }
    return s;
}

char* reverseParentheses(char* s) {
    int len = strlen(s);
    int* stack = (int*)malloc(len * sizeof(int));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else if (s[i] == ')') {
            int start = stack[top--] + 1;
            int end = i - 1;
            reverse(s, start, end);
        }
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] != '(' && s[i] != ')') {
            result[idx++] = s[i];
        }
    }
    result[idx] = '\0';
    free(stack);
    return result;
}