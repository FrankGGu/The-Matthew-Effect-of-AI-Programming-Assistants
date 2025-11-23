int increasingSubarrays(int* nums, int numsSize, int k) {
    for (int i = 0; i <= numsSize - k; i++) {
        int valid = 1;
        for (int j = i; j < i + k - 1; j++) {
            if (nums[j] >= nums[j + 1]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            return 1;
        }
    }
    return 0;
}