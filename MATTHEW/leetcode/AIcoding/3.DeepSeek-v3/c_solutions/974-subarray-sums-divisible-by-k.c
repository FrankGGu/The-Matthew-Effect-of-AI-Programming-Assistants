int subarraysDivByK(int* nums, int numsSize, int k) {
    int* modCount = (int*)calloc(k, sizeof(int));
    modCount[0] = 1;

    int prefixSum = 0;
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        int mod = prefixSum % k;
        if (mod < 0) mod += k;
        count += modCount[mod];
        modCount[mod]++;
    }

    free(modCount);
    return count;
}