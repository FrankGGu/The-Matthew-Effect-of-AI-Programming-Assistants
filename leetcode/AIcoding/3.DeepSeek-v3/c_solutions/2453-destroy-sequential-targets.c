int destroyTargets(int* nums, int numsSize, int space) {
    int maxCount = 0;
    int result = INT_MAX;
    int freq[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] % space]++;
        if (freq[nums[i] % space] > maxCount) {
            maxCount = freq[nums[i] % space];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i] % space] == maxCount && nums[i] < result) {
            result = nums[i];
        }
    }

    return result;
}