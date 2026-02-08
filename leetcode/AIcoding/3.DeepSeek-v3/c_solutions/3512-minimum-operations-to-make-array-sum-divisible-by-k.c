int minOperations(int* nums, int numsSize, int k) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum = (totalSum + nums[i]) % k;
    }

    if (totalSum % k == 0) {
        return 0;
    }

    return k - totalSum;
}