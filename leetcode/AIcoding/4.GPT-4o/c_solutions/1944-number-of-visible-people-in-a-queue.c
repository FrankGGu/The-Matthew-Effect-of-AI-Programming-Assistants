int* canSeePersonsCount(int* heights, int heightsSize, int* returnSize) {
    int* result = (int*)malloc(heightsSize * sizeof(int));
    int* stack = (int*)malloc(heightsSize * sizeof(int));
    int top = -1;

    for (int i = heightsSize - 1; i >= 0; i--) {
        while (top != -1 && stack[top] <= heights[i]) {
            top--;
        }
        result[i] = top + 1;
        stack[++top] = heights[i];
    }

    *returnSize = heightsSize;
    free(stack);
    return result;
}