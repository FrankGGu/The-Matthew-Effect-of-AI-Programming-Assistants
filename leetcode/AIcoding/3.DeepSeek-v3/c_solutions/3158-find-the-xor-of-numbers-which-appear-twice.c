int duplicateNumbersXOR(int* nums, int numsSize) {
    int seen[51] = {0};
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        if (seen[nums[i]] == 1) {
            result ^= nums[i];
        }
        seen[nums[i]]++;
    }

    return result;
}