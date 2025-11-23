int findFinalValue(int* nums, int numsSize, int original) {
    int found = 1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == original) {
            original *= 2;
            found = 1;
            i = -1; // Reset index to check for new original
        }
    }
    return original;
}