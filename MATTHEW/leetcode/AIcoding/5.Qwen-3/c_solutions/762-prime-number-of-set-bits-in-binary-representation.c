#include <stdio.h>
#include <stdlib.h>

int isPrime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int countSetBits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int countPrimeSetBits(int left, int right) {
    int count = 0;
    for (int i = left; i <= right; i++) {
        int bits = countSetBits(i);
        if (isPrime(bits)) {
            count++;
        }
    }
    return count;
}