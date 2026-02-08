#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int smallestRepunitDivisibleII(int n) {
    if (n % 2 == 0 || n % 5 == 0) return -1;

    int remainder = 1 % n;
    int length = 1;

    while (remainder != 0) {
        remainder = (remainder * 10 + 1) % n;
        length++;
    }

    return length;
}