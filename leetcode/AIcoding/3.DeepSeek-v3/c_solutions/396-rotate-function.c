int maxRotateFunction(int* nums, int numsSize) {
    long long sum = 0, f = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        f += i * nums[i];
    }

    long long maxF = f;
    for (int i = numsSize - 1; i > 0; i--) {
        f = f + sum - (long long)numsSize * nums[i];
        if (f > maxF) maxF = f;
    }

    return (int)maxF;
}