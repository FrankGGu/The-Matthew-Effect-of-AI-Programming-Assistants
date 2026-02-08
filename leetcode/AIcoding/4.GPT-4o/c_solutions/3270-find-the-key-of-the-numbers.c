int findKey(int* nums, int numsSize) {
    int key = 0;
    for (int i = 0; i < numsSize; i++) {
        key ^= nums[i];
    }
    return key;
}