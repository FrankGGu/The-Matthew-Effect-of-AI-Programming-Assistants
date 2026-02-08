int countOperationsToTarget(int* nums, int numsSize, int target) {
    int maxNum = 0, minNum = 1e9;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
        if (nums[i] < minNum) minNum = nums[i];
    }

    int result = 0;
    for (int i = 0; i <= maxNum; i++) {
        int currentTarget = target - i;
        if (currentTarget >= minNum && currentTarget <= maxNum) {
            result++;
        }
    }

    return result;
}