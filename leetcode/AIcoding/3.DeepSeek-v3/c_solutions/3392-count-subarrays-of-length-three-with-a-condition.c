int countSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize - 2; i++) {
        if (nums[i] == nums[i + 2]) {
            count++;
        }
    }
    return count;
}