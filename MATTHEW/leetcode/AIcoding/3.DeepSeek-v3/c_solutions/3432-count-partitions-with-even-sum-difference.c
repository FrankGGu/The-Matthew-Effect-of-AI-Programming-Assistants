int countPartitions(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int count = 0;
    int leftSum = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        leftSum += nums[i];
        int rightSum = total - leftSum;
        int diff = leftSum - rightSum;
        if (diff % 2 == 0) {
            count++;
        }
    }

    return count;
}