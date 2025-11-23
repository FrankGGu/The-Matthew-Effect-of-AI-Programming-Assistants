char* removeDuplicateLetters(char* s) {
    int last[26] = {0};
    int seen[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        last[s[i] - 'a'] = i;
    }

    char* stack = malloc(len + 1);
    int top = -1;

    for (int i = 0; i < len; i++) {
        int curr = s[i] - 'a';
        if (seen[curr]) continue;

        while (top != -1 && stack[top] > s[i] && last[stack[top] - 'a'] > i) {
            seen[stack[top] - 'a'] = 0;
            top--;
        }

        stack[++top] = s[i];
        seen[curr] = 1;
    }

    stack[top + 1] = '\0';
    return stack;
}