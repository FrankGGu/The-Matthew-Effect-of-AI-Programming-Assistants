int semiOrderedPermutation(int* nums, int numsSize) {
    int idx1 = -1;
    int idxn = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            idx1 = i;
        }
        if (nums[i] == numsSize) {
            idxn = i;
        }
    }

    int swaps = 0;

    swaps += idx1;

    swaps += (numsSize - 1) - idxn;

    if (idx1 > idxn) {
        swaps -= 1;
    }

    return swaps;
}