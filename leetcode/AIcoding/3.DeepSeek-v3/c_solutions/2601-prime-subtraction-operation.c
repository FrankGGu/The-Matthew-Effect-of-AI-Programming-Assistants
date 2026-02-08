int isPrime(int n) {
    if (n <= 1) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int getNextPrime(int n) {
    while (!isPrime(n)) n--;
    return n;
}

bool primeSubOperation(int* nums, int numsSize) {
    int prev = 0;
    for (int i = 0; i < numsSize; i++) {
        int curr = nums[i];
        if (curr <= prev) return false;
        int need = curr - prev - 1;
        if (need > 0) {
            int prime = getNextPrime(need);
            if (prime > 0) {
                curr -= prime;
            }
        }
        if (curr <= prev) return false;
        prev = curr;
    }
    return true;
}