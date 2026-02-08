int minimumSum(int* nums, int numsSize) {
    int* left = (int*)malloc(numsSize * sizeof(int));
    int* right = (int*)malloc(numsSize * sizeof(int));

    left[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        left[i] = (nums[i] < left[i-1]) ? nums[i] : left[i-1];
    }

    right[numsSize-1] = nums[numsSize-1];
    for (int i = numsSize-2; i >= 0; i--) {
        right[i] = (nums[i] < right[i+1]) ? nums[i] : right[i+1];
    }

    int minSum = INT_MAX;
    for (int i = 1; i < numsSize-1; i++) {
        if (nums[i] > left[i-1] && nums[i] > right[i+1]) {
            int sum = left[i-1] + nums[i] + right[i+1];
            if (sum < minSum) {
                minSum = sum;
            }
        }
    }

    free(left);
    free(right);
    return minSum == INT_MAX ? -1 : minSum;
}