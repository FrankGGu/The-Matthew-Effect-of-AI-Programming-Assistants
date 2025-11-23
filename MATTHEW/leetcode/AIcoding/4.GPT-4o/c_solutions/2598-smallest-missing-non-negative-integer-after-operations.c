int findSmallestInteger(int* nums, int numsSize, int value) {
    int count[numsSize];
    for (int i = 0; i < numsSize; i++) {
        count[i] = (nums[i] % value + value) % value;
    }
    int missing = 0;
    for (int i = 0; i < numsSize; i++) {
        if (count[i] == missing) {
            missing++;
        }
    }
    return missing;
}