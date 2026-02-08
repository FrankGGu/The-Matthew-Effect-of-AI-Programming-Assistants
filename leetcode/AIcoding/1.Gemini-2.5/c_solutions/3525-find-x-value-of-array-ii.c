int specialArray(int* nums, int numsSize) {
    for (int x = 1; x <= numsSize; x++) {
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] >= x) {
                count++;
            }
        }
        if (count == x) {
            return x;
        }
    }
    return -1;
}