#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long makeIntegerBeautiful(long long n, int target) {
    long long num = n;
    long long res = 0;
    long long base = 1;
    while (1) {
        long long temp = num;
        int sum = 0;
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }
        if (sum <= target) {
            break;
        }
        long long digit = num % 10;
        long long add = (10 - digit) % 10;
        res += add * base;
        num += add;
        num /= 10;
        base *= 10;
    }
    return res;
}