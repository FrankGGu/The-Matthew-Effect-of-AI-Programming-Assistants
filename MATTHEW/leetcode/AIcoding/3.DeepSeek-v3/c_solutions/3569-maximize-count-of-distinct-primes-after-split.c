int distinctPrimeFactors(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* primes = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; i++) {
        primes[i] = 1;
    }
    primes[0] = primes[1] = 0;

    for (int i = 2; i * i <= max_val; i++) {
        if (primes[i]) {
            for (int j = i * i; j <= max_val; j += i) {
                primes[j] = 0;
            }
        }
    }

    int* factors = (int*)calloc(max_val + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = 2; j * j <= num; j++) {
            if (primes[j] && num % j == 0) {
                factors[j] = 1;
                while (num % j == 0) {
                    num /= j;
                }
            }
        }
        if (num > 1 && primes[num]) {
            factors[num] = 1;
        }
    }

    int count = 0;
    for (int i = 2; i <= max_val; i++) {
        if (factors[i]) {
            count++;
        }
    }

    free(primes);
    free(factors);
    return count;
}