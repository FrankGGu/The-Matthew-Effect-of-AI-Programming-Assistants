int is_prime(int n) {
    if (n <= 1) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int mostFrequentPrime(int* nums, int numsSize) {
    int frequency[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (is_prime(nums[i])) {
            frequency[nums[i]]++;
        }
    }
    int max_freq = 0;
    int result = -1;
    for (int i = 2; i < 1001; i++) {
        if (frequency[i] > max_freq) {
            max_freq = frequency[i];
            result = i;
        }
    }
    return result;
}