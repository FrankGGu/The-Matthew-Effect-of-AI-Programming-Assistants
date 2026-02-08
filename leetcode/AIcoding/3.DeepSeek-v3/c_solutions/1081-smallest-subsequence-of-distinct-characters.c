char* smallestSubsequence(char* s) {
    int last[26];
    memset(last, -1, sizeof(last));
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        last[s[i] - 'a'] = i;
    }

    char* stack = malloc((len + 1) * sizeof(char));
    int top = -1;
    int seen = 0;

    for (int i = 0; i < len; i++) {
        int c = s[i] - 'a';
        if (seen & (1 << c)) continue;

        while (top != -1 && stack[top] > s[i] && last[stack[top] - 'a'] > i) {
            seen &= ~(1 << (stack[top] - 'a'));
            top--;
        }

        stack[++top] = s[i];
        seen |= (1 << c);
    }

    stack[top + 1] = '\0';
    return stack;
}