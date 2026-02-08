int findMax(int* nums, int numsSize) {
    int maxNum = 0;
    int exists[1001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            exists[nums[i]] = 1;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0 && -nums[i] < 1001 && exists[-nums[i]]) {
            maxNum = maxNum > -nums[i] ? maxNum : -nums[i];
        }
    }

    return maxNum;
}