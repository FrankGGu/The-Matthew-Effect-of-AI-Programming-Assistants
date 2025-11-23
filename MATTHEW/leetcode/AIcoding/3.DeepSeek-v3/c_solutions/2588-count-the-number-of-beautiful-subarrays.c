int beautifulSubarrays(int* nums, int numsSize) {
    int count = 0;
    int xorSum = 0;
    int freq[2000000] = {0};
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        xorSum ^= nums[i];
        count += freq[xorSum];
        freq[xorSum]++;
    }

    return count;
}