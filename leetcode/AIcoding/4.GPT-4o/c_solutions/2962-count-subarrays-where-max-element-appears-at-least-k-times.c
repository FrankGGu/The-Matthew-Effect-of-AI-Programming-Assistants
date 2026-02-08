int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int maxCount = 0;
        int maxVal = nums[i];
        for (int j = i; j < numsSize; j++) {
            if (nums[j] > maxVal) {
                maxVal = nums[j];
                maxCount = 1;
            } else if (nums[j] == maxVal) {
                maxCount++;
            }
            if (maxCount >= k) {
                count++;
            }
        }
    }
    return count;
}