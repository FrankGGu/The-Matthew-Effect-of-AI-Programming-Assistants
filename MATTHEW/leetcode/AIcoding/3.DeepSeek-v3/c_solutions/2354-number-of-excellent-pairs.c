int countExcellentPairs(int* nums, int numsSize, int k) {
    long long count[32] = {0};
    int seen[100000000] = {0};
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (seen[num]) continue;
        seen[num] = 1;
        int bits = __builtin_popcount(num);
        count[bits]++;
    }

    long long result = 0;
    for (int i = 0; i < 32; i++) {
        for (int j = 0; j < 32; j++) {
            if (i + j >= k) {
                result += count[i] * count[j];
            }
        }
    }
    return result;
}