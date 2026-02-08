int zeroFilledSubarray(int* nums, int numsSize) {
    long long count = 0, current = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            current++;
            count += current;
        } else {
            current = 0;
        }
    }
    return count;
}