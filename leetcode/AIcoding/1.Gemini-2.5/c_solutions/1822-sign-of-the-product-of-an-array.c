int arraySign(int* nums, int numsSize) {
    int negativeCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            return 0;
        } else if (nums[i] < 0) {
            negativeCount++;
        }
    }

    if (negativeCount % 2 == 0) {
        return 1;
    } else {
        return -1;
    }
}