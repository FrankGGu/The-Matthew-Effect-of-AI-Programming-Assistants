int distinctPrimeFactors(int* nums, int numsSize) {
    int factors[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        for (int f = 2; f * f <= n; f++) {
            if (n % f == 0) {
                factors[f] = 1;
                while (n % f == 0) {
                    n /= f;
                }
            }
        }
        if (n > 1) {
            factors[n] = 1;
        }
    }

    int count = 0;
    for (int i = 0; i < 1001; i++) {
        if (factors[i]) {
            count++;
        }
    }
    return count;
}