int minMoves(int* nums, int numsSize) {
    int min = nums[0];
    long sum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min) {
            min = nums[i];
        }
        sum += nums[i];
    }

    return (int)(sum - (long)min * numsSize);
}