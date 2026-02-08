int countElements(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int min_val = nums[0];
    int max_val = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) min_val = nums[i];
        if (nums[i] > max_val) max_val = nums[i];
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > min_val && nums[i] < max_val) {
            count++;
        }
    }

    return count;
}