int maximumBeauty(int* nums, int numsSize, int k) {
    int maxBeauty = 0;
    int minVal = INT_MAX;
    int maxVal = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    for (int i = minVal; i <= maxVal; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (abs(nums[j] - i) <= k) {
                count++;
            }
        }
        if (count > maxBeauty) {
            maxBeauty = count;
        }
    }

    return maxBeauty;
}