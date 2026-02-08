int maxWidthRamp(int* nums, int numsSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        if (top == -1 || nums[i] < nums[stack[top]]) {
            stack[++top] = i;
        }
    }

    int maxWidth = 0;
    for (int j = numsSize - 1; j >= 0; j--) {
        while (top >= 0 && nums[j] >= nums[stack[top]]) {
            int width = j - stack[top];
            if (width > maxWidth) {
                maxWidth = width;
            }
            top--;
        }
    }

    free(stack);
    return maxWidth;
}