int is_prime(int n) {
    if (n <= 1) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int max_prime_diff(int *nums, int numsSize) {
    int max_prime = -1, min_prime = 101;
    for (int i = 0; i < numsSize; i++) {
        if (is_prime(nums[i])) {
            if (nums[i] > max_prime) max_prime = nums[i];
            if (nums[i] < min_prime) min_prime = nums[i];
        }
    }
    return (max_prime == -1 || min_prime == 101) ? -1 : max_prime - min_prime;
}