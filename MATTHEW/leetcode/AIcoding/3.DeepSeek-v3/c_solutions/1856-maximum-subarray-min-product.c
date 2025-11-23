int maxSumMinProduct(int* nums, int numsSize) {
    long long* prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* stack = (int*)malloc(numsSize * sizeof(int));
    int* left = (int*)malloc(numsSize * sizeof(int));
    int* right = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && nums[stack[top]] >= nums[i]) {
            top--;
        }
        left[i] = (top == -1) ? -1 : stack[top];
        stack[++top] = i;
    }

    top = -1;
    for (int i = numsSize - 1; i >= 0; i--) {
        while (top >= 0 && nums[stack[top]] >= nums[i]) {
            top--;
        }
        right[i] = (top == -1) ? numsSize : stack[top];
        stack[++top] = i;
    }

    long long maxProduct = 0;
    for (int i = 0; i < numsSize; i++) {
        long long sum = prefix[right[i]] - prefix[left[i] + 1];
        long long product = (long long)nums[i] * sum;
        if (product > maxProduct) {
            maxProduct = product;
        }
    }

    free(prefix);
    free(stack);
    free(left);
    free(right);

    return maxProduct % 1000000007;
}