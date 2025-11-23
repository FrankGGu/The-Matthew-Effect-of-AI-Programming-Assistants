int findLargestInteger(int* nums, int numsSize) {
    int count[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    for (int i = 1000; i >= 0; i--) {
        if (count[i] == 0 && count[i - 1] > 0) {
            return i;
        }
    }
    return -1;
}