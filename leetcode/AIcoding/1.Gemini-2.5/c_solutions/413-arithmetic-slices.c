int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    int total_slices = 0;
    int current_slices_count = 0;

    for (int i = 2; i < numsSize; i++) {
        if (nums[i] - nums[i-1] == nums[i-1] - nums[i-2]) {
            current_slices_count++;
        } else {
            current_slices_count = 0;
        }
        total_slices += current_slices_count;
    }

    return total_slices;
}