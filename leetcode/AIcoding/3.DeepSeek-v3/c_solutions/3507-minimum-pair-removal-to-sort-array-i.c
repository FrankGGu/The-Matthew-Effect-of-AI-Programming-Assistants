int minimumPairRemoval(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            count++;
            i++;
        }
    }
    return count;
}