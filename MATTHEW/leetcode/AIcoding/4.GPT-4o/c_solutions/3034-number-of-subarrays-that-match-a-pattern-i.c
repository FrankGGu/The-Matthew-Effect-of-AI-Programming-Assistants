int numSubarraysWithPattern(int* nums, int numsSize, int* pattern, int patternSize) {
    int count = 0, i, j;
    for (i = 0; i <= numsSize - patternSize; i++) {
        for (j = 0; j < patternSize; j++) {
            if (nums[i + j] != pattern[j]) {
                break;
            }
        }
        if (j == patternSize) {
            count++;
        }
    }
    return count;
}