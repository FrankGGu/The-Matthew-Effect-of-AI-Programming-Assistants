int countInterestingSubarrays(int* nums, int numsSize, int modulo, int k) {
    int count = 0;
    int prefix = 0;
    int* freq = (int*)calloc(modulo, sizeof(int));
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefix += (nums[i] % modulo == k);
        prefix %= modulo;
        int target = (prefix - k + modulo) % modulo;
        count += freq[target];
        freq[prefix]++;
    }

    free(freq);
    return count;
}