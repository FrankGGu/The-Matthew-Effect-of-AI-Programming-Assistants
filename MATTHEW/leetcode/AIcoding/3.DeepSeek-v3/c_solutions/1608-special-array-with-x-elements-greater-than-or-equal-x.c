int specialArray(int* nums, int numsSize) {
    int count[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int total = 0;
    for (int x = 1000; x >= 0; x--) {
        total += count[x];
        if (total == x) {
            return x;
        }
    }
    return -1;
}