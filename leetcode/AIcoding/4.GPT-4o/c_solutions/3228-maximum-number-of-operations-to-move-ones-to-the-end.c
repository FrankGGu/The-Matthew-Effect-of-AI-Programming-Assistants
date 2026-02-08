int maximumOperations(int* nums, int numsSize) {
    int count = 0, ones = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones++;
        } else {
            count++;
        }
    }

    return count < ones ? count : ones;
}