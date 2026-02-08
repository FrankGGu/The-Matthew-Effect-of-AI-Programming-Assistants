int maxRotateFunction(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    long long sumAllElements = 0;
    long long currentF = 0;

    for (int i = 0; i < numsSize; i++) {
        sumAllElements += nums[i];
        currentF += (long long)i * nums[i];
    }

    long long maxF = currentF;

    for (int k = 1; k < numsSize; k++) {
        currentF += sumAllElements - (long long)numsSize * nums[numsSize - k];
        if (currentF > maxF) {
            maxF = currentF;
        }
    }

    return (int)maxF;
}