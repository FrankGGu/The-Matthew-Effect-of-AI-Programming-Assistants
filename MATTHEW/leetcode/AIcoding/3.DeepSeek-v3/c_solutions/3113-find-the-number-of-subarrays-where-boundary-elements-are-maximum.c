int numberOfSubarrays(int* nums, int numsSize) {
    long long result = 0;
    int stack[numsSize];
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && nums[stack[top]] < nums[i]) {
            top--;
        }

        if (top >= 0 && nums[stack[top]] == nums[i]) {
            stack[top] = i;
        } else {
            stack[++top] = i;
        }

        result += top + 1;
    }

    return result;
}