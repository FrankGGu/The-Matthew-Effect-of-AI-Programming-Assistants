int digitDifference(int num1, int num2) {
    int diff = 0;
    while (num1 > 0 || num2 > 0) {
        int d1 = num1 % 10;
        int d2 = num2 % 10;
        if (d1 != d2) diff++;
        num1 /= 10;
        num2 /= 10;
    }
    return diff;
}

long long sumDigitDifferences(int* nums, int numsSize) {
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            total += digitDifference(nums[i], nums[j]);
        }
    }
    return total;
}