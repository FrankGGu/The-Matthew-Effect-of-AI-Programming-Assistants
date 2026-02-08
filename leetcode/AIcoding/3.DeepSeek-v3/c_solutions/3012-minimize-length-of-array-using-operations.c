int minimumArrayLength(int* nums, int numsSize) {
    int min_val = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) {
            min_val = nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % min_val != 0) {
            return 1;
        }
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == min_val) {
            count++;
        }
    }

    return (count + 1) / 2;
}