int countInterestingSubarrays(int* nums, int numsSize, int modulo) {
    int count = 0;
    int prefixCount = 0;
    int* prefix = (int*)calloc(numsSize + 1, sizeof(int));
    int* freq = (int*)calloc(modulo, sizeof(int));

    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 1) {
            prefixCount++;
        }
        int modValue = prefixCount % modulo;
        count += freq[modValue];
        freq[modValue]++;
    }

    free(prefix);
    free(freq);

    return count;
}