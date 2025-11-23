int semiOrderedPermutation(int* nums, int numsSize) {
    int first = -1, last = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) first = i;
        if (nums[i] == numsSize) last = i;
    }
    int result = 0;
    if (first < last) {
        result = first + (numsSize - 1 - last);
    } else {
        result = first + (numsSize - 1 - last) - 1;
    }
    return result;
}