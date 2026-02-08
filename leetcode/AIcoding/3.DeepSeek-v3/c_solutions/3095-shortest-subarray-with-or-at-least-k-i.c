int minimumSubarrayLength(int* nums, int numsSize, int k) {
    int minLen = numsSize + 1;

    for (int i = 0; i < numsSize; i++) {
        int currentOr = 0;
        for (int j = i; j < numsSize; j++) {
            currentOr |= nums[j];
            if (currentOr >= k) {
                if (j - i + 1 < minLen) {
                    minLen = j - i + 1;
                }
                break;
            }
        }
    }

    return minLen == numsSize + 1 ? -1 : minLen;
}