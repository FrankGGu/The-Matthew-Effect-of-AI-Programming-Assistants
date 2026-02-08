int countOperationsToEmptyArray(int* nums, int numsSize) {
    int operations = 0;
    int index[numsSize];
    for (int i = 0; i < numsSize; i++) {
        index[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            if (nums[index[j]] < nums[index[i]]) {
                operations++;
            }
        }
    }

    return operations + numsSize;
}