int minMoves(int* nums, int numsSize) {
    int sum = 0, minNum = nums[0];
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (nums[i] < minNum) {
            minNum = nums[i];
        }
    }
    return sum - minNum * numsSize;
}