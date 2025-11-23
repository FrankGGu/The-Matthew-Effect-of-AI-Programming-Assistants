long long subArrayRanges(int* nums, int numsSize) {
    long long totalSum = 0;

    for (int i = 0; i < numsSize; ++i) {
        int minVal = nums[i];
        int maxVal = nums[i];

        for (int j = i; j < numsSize; ++j) {
            if (nums[j] < minVal) {
                minVal = nums[j];
            }
            if (nums[j] > maxVal) {
                maxVal = nums[j];
            }
            totalSum += (maxVal - minVal);
        }
    }

    return totalSum;
}