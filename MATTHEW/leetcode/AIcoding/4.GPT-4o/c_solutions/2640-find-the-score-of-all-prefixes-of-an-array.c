int* findPrefixScore(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    long long maxNum = 0, prefixSum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
        prefixSum += nums[i] + maxNum;
        result[i] = prefixSum;
    }

    return result;
}