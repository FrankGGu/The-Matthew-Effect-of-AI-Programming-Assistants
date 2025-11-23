char* removeDuplicates(char* s, int k) {
    int n = strlen(s);
    int* count = (int*)malloc(n * sizeof(int));
    int top = -1;
    char* stack = (char*)malloc((n + 1) * sizeof(char));

    for (int i = 0; i < n; i++) {
        if (top >= 0 && stack[top] == s[i]) {
            count[top]++;
            if (count[top] == k) {
                top--;
            }
        } else {
            top++;
            stack[top] = s[i];
            count[top] = 1;
        }
    }

    char* result = (char*)malloc((n + 1) * sizeof(char));
    int idx = 0;
    for (int i = 0; i <= top; i++) {
        for (int j = 0; j < count[i]; j++) {
            result[idx++] = stack[i];
        }
    }
    result[idx] = '\0';

    free(stack);
    free(count);
    return result;
}