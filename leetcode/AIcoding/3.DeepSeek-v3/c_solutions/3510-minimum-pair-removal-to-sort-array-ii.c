int minimumPairRemoval(int* nums, int numsSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;
    int max = -1;

    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && stack[top] > nums[i]) {
            if (max < stack[top]) {
                max = stack[top];
            }
            top--;
        }

        if (nums[i] < max) {
            top--;
            while (top >= 0 && stack[top] > nums[i]) {
                top--;
            }
        }

        stack[++top] = nums[i];
    }

    free(stack);
    return numsSize - (top + 1);
}