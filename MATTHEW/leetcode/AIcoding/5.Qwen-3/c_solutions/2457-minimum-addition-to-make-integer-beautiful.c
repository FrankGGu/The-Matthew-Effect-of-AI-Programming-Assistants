#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long minimumAddition(long long num, int target) {
    long long original = num;
    long long power = 1;
    while (num > 0) {
        num /= 10;
        power *= 10;
    }
    long long next = power;
    while (next < original) {
        next += power;
    }
    return next - original;
}