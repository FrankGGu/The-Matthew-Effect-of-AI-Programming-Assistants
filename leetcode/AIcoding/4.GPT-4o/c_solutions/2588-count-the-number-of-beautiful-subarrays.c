int countBeautifulSubarrays(int* nums, int numsSize) {
    int count = 0, prefixXor = 0;
    int freq[100001] = {0};
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefixXor ^= nums[i];
        count += freq[prefixXor];
        freq[prefixXor]++;
    }

    return count;
}