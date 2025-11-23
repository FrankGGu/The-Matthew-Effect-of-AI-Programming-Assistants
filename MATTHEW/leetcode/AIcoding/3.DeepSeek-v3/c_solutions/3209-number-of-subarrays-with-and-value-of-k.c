int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int andVal = nums[i];
        if (andVal == k) count++;
        for (int j = i + 1; j < numsSize; j++) {
            andVal &= nums[j];
            if (andVal == k) count++;
            if (andVal < k) break;
        }
    }
    return count;
}