int minimumSum(int* nums, int numsSize) {
    int minSum = 2000000000; // A sufficiently large value
    int found = 0;

    for (int i = 0; i < numsSize - 2; i++) {
        for (int j = i + 1; j < numsSize - 1; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] < nums[j] && nums[k] < nums[j]) {
                    int currentSum = nums[i] + nums[j] + nums[k];
                    if (currentSum < minSum) {
                        minSum = currentSum;
                    }
                    found = 1;
                }
            }
        }
    }

    if (found) {
        return minSum;
    } else {
        return -1;
    }
}