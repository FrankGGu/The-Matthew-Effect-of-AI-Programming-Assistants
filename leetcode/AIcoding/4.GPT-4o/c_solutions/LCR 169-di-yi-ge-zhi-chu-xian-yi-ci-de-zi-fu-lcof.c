int minOperations(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        while (nums[i] > 0) {
            nums[i] &= (nums[i] - 1);
            count++;
        }
    }
    return count;
}