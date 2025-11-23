long long subArrayRanges(int* nums, int numsSize) {
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        int maxVal = nums[i], minVal = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] > maxVal) maxVal = nums[j];
            if (nums[j] < minVal) minVal = nums[j];
            total += maxVal - minVal;
        }
    }
    return total;
}