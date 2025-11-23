int longestWPI(int* hours, int hoursSize) {
    int* prefix = (int*)malloc((hoursSize + 1) * sizeof(int));
    prefix[0] = 0;

    for (int i = 0; i < hoursSize; i++) {
        prefix[i + 1] = prefix[i] + (hours[i] > 8 ? 1 : -1);
    }

    int* stack = (int*)malloc((hoursSize + 1) * sizeof(int));
    int top = -1;
    stack[++top] = 0;

    for (int i = 1; i <= hoursSize; i++) {
        if (prefix[i] < prefix[stack[top]]) {
            stack[++top] = i;
        }
    }

    int maxLen = 0;
    for (int j = hoursSize; j > 0; j--) {
        while (top >= 0 && prefix[j] > prefix[stack[top]]) {
            maxLen = (j - stack[top]) > maxLen ? (j - stack[top]) : maxLen;
            top--;
        }
    }

    free(prefix);
    free(stack);
    return maxLen;
}