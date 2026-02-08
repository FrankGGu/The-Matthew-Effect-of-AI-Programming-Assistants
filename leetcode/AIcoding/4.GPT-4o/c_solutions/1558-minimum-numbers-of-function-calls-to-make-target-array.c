int minOperations(int* nums, int numsSize) {
    int maxNum = 0, operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    while (maxNum > 0) {
        operations += maxNum & 1;
        maxNum >>= 1;
    }
    return operations + (int)log2(maxNum + 1);
}