int findFinalValue(int* nums, int numsSize, int original) {
    int found;
    do {
        found = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] == original) {
                original *= 2;
                found = 1;
                break;
            }
        }
    } while (found);

    return original;
}