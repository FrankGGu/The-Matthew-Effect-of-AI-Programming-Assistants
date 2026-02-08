int countPrimeSetBits(int left, int right) {
    int primes[] = {0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1};
    int count = 0;

    for (int i = left; i <= right; i++) {
        int bits = __builtin_popcount(i);
        if (primes[bits]) {
            count++;
        }
    }

    return count;
}