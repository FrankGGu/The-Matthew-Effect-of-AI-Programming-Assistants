bool canAliceWin(int* nums, int numsSize) {
    int singleSum = 0, doubleSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 10) {
            singleSum += nums[i];
        } else {
            doubleSum += nums[i];
        }
    }

    if (singleSum == doubleSum) {
        return false;
    }
    return true;
}