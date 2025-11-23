int countBadPairs(int* nums, int numsSize) {
    long long totalPairs = (long long)numsSize * (numsSize - 1) / 2;
    long long goodPairs = 0;
    for (int i = 0; i < numsSize; i++) {
        goodPairs += (i - nums[i]);
    }
    goodPairs += numsSize;
    return totalPairs - goodPairs;
}