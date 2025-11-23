int findGCD(int* nums, int numsSize) {
    int minNum = nums[0], maxNum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minNum) minNum = nums[i];
        if (nums[i] > maxNum) maxNum = nums[i];
    }

    while (maxNum % minNum != 0) {
        int temp = maxNum % minNum;
        maxNum = minNum;
        minNum = temp;
    }
    return minNum;
}