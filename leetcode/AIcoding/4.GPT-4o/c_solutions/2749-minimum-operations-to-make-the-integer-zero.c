int minimumOperations(int* nums, int numsSize) {
    int count = 0;
    int min_nonzero = 101; // Since nums[i] is in the range [0, 100]

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && nums[i] < min_nonzero) {
            min_nonzero = nums[i];
        }
    }

    while (min_nonzero <= 100) {
        count++;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] >= min_nonzero) {
                nums[i] -= min_nonzero;
            }
        }

        min_nonzero = 101; // Reset for next iteration
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] > 0 && nums[i] < min_nonzero) {
                min_nonzero = nums[i];
            }
        }
    }

    return count;
}