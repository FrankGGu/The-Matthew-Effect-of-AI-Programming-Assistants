int minimumSum(int* nums, int numsSize) {
    int minSum = -1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] < nums[j] && nums[k] < nums[j]) {
                    int sum = nums[i] + nums[j] + nums[k];
                    if (minSum == -1 || sum < minSum) {
                        minSum = sum;
                    }
                }
            }
        }
    }

    return minSum;
}