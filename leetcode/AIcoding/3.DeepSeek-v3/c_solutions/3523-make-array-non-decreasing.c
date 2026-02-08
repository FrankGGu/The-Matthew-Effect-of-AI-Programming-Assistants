int totalSteps(int* nums, int numsSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int* steps = (int*)malloc(numsSize * sizeof(int));
    int top = -1;
    int maxSteps = 0;

    for (int i = numsSize - 1; i >= 0; i--) {
        int currentSteps = 0;
        while (top >= 0 && nums[i] > nums[stack[top]]) {
            currentSteps = (currentSteps + 1 > steps[stack[top]]) ? currentSteps + 1 : steps[stack[top]];
            top--;
        }
        steps[i] = currentSteps;
        stack[++top] = i;
        if (currentSteps > maxSteps) {
            maxSteps = currentSteps;
        }
    }

    free(stack);
    free(steps);
    return maxSteps;
}