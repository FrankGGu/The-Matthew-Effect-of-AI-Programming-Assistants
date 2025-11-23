int semiOrderedPermutation(int* nums, int numsSize) {
    int pos1 = -1, posN = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) pos1 = i;
        if (nums[i] == numsSize) posN = i;
    }

    if (pos1 < posN) {
        return pos1 + (numsSize - 1 - posN);
    } else {
        return pos1 + (numsSize - 1 - posN) - 1;
    }
}