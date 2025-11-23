#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int count(int n) {
    int count = 0;
    while (n > 0) {
        n /= 10;
        count++;
    }
    return count;
}

long long power(int base, int exp) {
    long long result = 1;
    for (int i = 0; i < exp; i++) {
        result *= base;
    }
    return result;
}

long long sumOfGoodNumbers(int n) {
    long long total = 0;
    for (int i = 1; i <= n; i++) {
        int digits = count(i);
        long long sum = 0;
        int num = i;
        for (int j = 0; j < digits; j++) {
            int digit = num % 10;
            sum += power(digit, digits);
            num /= 10;
        }
        if (sum == i) {
            total += i;
        }
    }
    return total;
}