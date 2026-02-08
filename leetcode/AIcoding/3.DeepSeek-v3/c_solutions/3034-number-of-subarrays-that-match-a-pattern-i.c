int countMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    int count = 0;
    for (int i = 0; i <= numsSize - patternSize - 1; i++) {
        int match = 1;
        for (int j = 0; j < patternSize; j++) {
            if (pattern[j] == 1 && nums[i + j + 1] <= nums[i + j]) {
                match = 0;
                break;
            } else if (pattern[j] == 0 && nums[i + j + 1] != nums[i + j]) {
                match = 0;
                break;
            } else if (pattern[j] == -1 && nums[i + j + 1] >= nums[i + j]) {
                match = 0;
                break;
            }
        }
        if (match) {
            count++;
        }
    }
    return count;
}