int countPrimeSetBits(int left, int right) {
    int primes[] = {2, 3, 5, 7, 11, 13, 17, 19};
    int count = 0;

    for (int i = left; i <= right; i++) {
        int setBits = 0;
        int num = i;
        while (num > 0) {
            num &= (num - 1);
            setBits++;
        }

        for (int j = 0; j < sizeof(primes) / sizeof(primes[0]); j++) {
            if (setBits == primes[j]) {
                count++;
                break;
            }
        }
    }

    return count;
}