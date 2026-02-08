int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    int* result = (int*)malloc(temperaturesSize * sizeof(int));
    int* stack = (int*)malloc(temperaturesSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < temperaturesSize; i++) {
        while (top != -1 && temperatures[i] > temperatures[stack[top]]) {
            int idx = stack[top--];
            result[idx] = i - idx;
        }
        stack[++top] = i;
    }

    while (top != -1) {
        result[stack[top--]] = 0;
    }

    *returnSize = temperaturesSize;
    free(stack);
    return result;
}