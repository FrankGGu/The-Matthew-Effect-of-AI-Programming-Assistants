int removeDuplicates(int* nums, int numsSize) {
    if (numsSize <= 2) return numsSize;
    int count = 1, index = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1]) {
            count++;
        } else {
            count = 1;
        }

        if (count <= 2) {
            nums[index++] = nums[i];
        }
    }

    return index;
}