int countGoodPairs(int* nums, int numsSize) {
    int count = 0;
    int freq[1001] = {0};

    for (int i = 0; i < numsSize; i++) {
        count += freq[nums[i]];
        freq[nums[i]]++;
    }

    return count;
}