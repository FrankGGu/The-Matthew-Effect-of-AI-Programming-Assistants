int findValidSplit(int* nums, int numsSize) {
    int gcd[numsSize + 1];
    gcd[0] = 0;
    for (int i = 1; i <= numsSize; i++) {
        gcd[i] = nums[i - 1];
        for (int j = 1; j < i; j++) {
            gcd[i] = __gcd(gcd[i], nums[j]);
        }
    }

    for (int i = 1; i < numsSize; i++) {
        if (gcd[i] == 1) {
            return 1;
        }
    }

    return 0;
}