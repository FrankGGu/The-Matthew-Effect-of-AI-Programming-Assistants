#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int countDistinctPrimes(int n) {
    int count = 0;
    for (int i = 2; i <= n; i++) {
        int isPrime = 1;
        for (int j = 2; j * j <= i; j++) {
            if (i % j == 0) {
                isPrime = 0;
                break;
            }
        }
        if (isPrime) count++;
    }
    return count;
}

int maxDiff(int n) {
    int maxDiff = 0;
    for (int i = 2; i < n; i++) {
        int left = i;
        int right = n - i;
        int leftPrimes = countDistinctPrimes(left);
        int rightPrimes = countDistinctPrimes(right);
        maxDiff = fmax(maxDiff, abs(leftPrimes - rightPrimes));
    }
    return maxDiff;
}

int maxDiff(int n);