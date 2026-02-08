int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    int* result = (int*)malloc(temperaturesSize * sizeof(int));
    int* stack = (int*)malloc(temperaturesSize * sizeof(int));
    int top = -1;
    *returnSize = temperaturesSize;

    for (int i = 0; i < temperaturesSize; i++) {
        while (top >= 0 && temperatures[i] > temperatures[stack[top]]) {
            int idx = stack[top--];
            result[idx] = i - idx;
        }
        stack[++top] = i;
    }

    while (top >= 0) {
        result[stack[top--]] = 0;
    }

    free(stack);
    return result;
}