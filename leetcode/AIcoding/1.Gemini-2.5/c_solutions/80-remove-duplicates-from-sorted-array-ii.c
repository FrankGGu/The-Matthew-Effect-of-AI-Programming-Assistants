int removeDuplicates(int* nums, int numsSize) {
    if (numsSize <= 2) {
        return numsSize;
    }

    int k = 2; // k is the next position to write to

    for (int i = 2; i < numsSize; i++) {
        // If the current element nums[i] is different from nums[k-2]
        // (the element two positions before the current write position),
        // then it's either a new unique element or it's the second occurrence
        // of an element that was previously written.
        if (nums[i] != nums[k - 2]) {
            nums[k] = nums[i];
            k++;
        }
    }

    return k;
}