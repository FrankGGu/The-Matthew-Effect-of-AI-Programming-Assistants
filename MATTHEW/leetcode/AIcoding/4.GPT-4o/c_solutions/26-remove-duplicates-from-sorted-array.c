int removeDuplicates(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int count = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[count - 1]) {
            nums[count] = nums[i];
            count++;
        }
    }
    return count;
}