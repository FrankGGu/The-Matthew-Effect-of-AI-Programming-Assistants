int minOperations(int* nums, int numsSize) {
    int operations = 0;
    int maxNum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    if (maxNum == 1) return 0;

    for (int i = 0; i < numsSize; i++) {
        while (nums[i] > 1) {
            if (nums[i] % 2 == 0) {
                nums[i] /= 2;
            } else {
                nums[i]--;
            }
            operations++;
        }
    }

    return operations;
}