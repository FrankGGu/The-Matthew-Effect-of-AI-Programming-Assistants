#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrime(long long n) {
    if (n <= 1) return false;
    for (long long i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

long long sumOfMaxPrimeSubstrings(char *s) {
    long long sum = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            char sub[11];
            int len = j - i + 1;
            if (len > 10) continue;
            strncpy(sub, s + i, len);
            sub[len] = '\0';

            long long num = atoll(sub);
            if (num > 0 && num <= 1000 && isPrime(num)) {
                sum += num;
                i = j;
                break;
            }
        }
    }
    return sum;
}