#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

int primeSetBits(int left, int right) {
    int count = 0;
    for (int i = left; i <= right; i++) {
        int setBits = countSetBits(i);
        if (isPrime(setBits)) {
            count++;
        }
    }
    return count;
}