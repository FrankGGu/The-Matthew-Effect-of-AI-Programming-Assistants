int countWays(int* nums, int numsSize) {
    int count = 0;
    int selected = 0;

    for (int i = 0; i <= numsSize; i++) {
        selected = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] < i) selected++;
        }
        if (selected == i) count++;
    }

    return count;
}