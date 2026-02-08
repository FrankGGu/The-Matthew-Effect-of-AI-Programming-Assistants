int* applyOperations(int* nums, int numsSize, int* returnSize) {
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == nums[i+1]) {
            nums[i] *= 2;
            nums[i+1] = 0;
        }
    }

    int write_idx = 0;
    for (int read_idx = 0; read_idx < numsSize; read_idx++) {
        if (nums[read_idx] != 0) {
            nums[write_idx] = nums[read_idx];
            write_idx++;
        }
    }

    while (write_idx < numsSize) {
        nums[write_idx] = 0;
        write_idx++;
    }

    *returnSize = numsSize;
    return nums;
}