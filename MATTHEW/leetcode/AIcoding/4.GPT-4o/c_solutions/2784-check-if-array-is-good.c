bool isGood(int* nums, int numsSize) {
    int count[numsSize + 1];
    memset(count, 0, sizeof(count));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= numsSize) {
            count[nums[i]]++;
        }
    }

    for (int i = 1; i <= numsSize; i++) {
        if (count[i] != i && count[i] != 0) {
            return false;
        }
    }

    return true;
}