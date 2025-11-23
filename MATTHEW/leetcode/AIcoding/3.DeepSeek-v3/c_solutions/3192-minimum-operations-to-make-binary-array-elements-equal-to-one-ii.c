int minOperations(int* nums, int numsSize) {
    int flips = 0;
    int flipState = 0;

    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] + flipState) % 2 == 0) {
            flips++;
            flipState ^= 1;
        }
    }

    return flips;
}