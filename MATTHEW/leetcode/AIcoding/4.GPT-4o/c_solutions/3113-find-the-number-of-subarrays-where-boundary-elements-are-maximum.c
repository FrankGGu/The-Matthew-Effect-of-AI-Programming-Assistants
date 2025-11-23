int countSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int max_val = nums[i];
        for (int j = i; j < numsSize; j++) {
            max_val = max_val > nums[j] ? max_val : nums[j];
            if (j == i || nums[j] == max_val) {
                count++;
            }
        }
    }
    return count;
}