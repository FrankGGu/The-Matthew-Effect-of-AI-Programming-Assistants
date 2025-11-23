/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* canSeePersonsCount(int* heights, int heightsSize, int* returnSize) {
    *returnSize = heightsSize;
    int* res = (int*)calloc(heightsSize, sizeof(int));
    int* stack = (int*)malloc(heightsSize * sizeof(int));
    int top = -1;

    for (int i = heightsSize - 1; i >= 0; i--) {
        int count = 0;
        while (top >= 0 && heights[i] > heights[stack[top]]) {
            count++;
            top--;
        }
        if (top >= 0) count++;
        res[i] = count;
        stack[++top] = i;
    }

    free(stack);
    return res;
}