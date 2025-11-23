int* dailyTemperatures(int* T, int TSize, int* returnSize) {
    int* result = (int*)malloc(TSize * sizeof(int));
    int* stack = (int*)malloc(TSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < TSize; i++) {
        while (top != -1 && T[i] > T[stack[top]]) {
            int idx = stack[top--];
            result[idx] = i - idx;
        }
        stack[++top] = i;
    }

    while (top != -1) {
        result[stack[top--]] = 0;
    }

    *returnSize = TSize;
    free(stack);
    return result;
}