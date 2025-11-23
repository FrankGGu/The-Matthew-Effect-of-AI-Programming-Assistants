int countBeautifulPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) == 1) {
                count++;
            }
        }
    }
    return count;
}