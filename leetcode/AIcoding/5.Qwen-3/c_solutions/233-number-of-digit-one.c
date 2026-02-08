#include <stdio.h>
#include <stdlib.h>

int countDigitOne(int n) {
    int count = 0;
    long i = 1;
    while (i <= n) {
        long divider = i * 10;
        count += (n / divider) * i;
        long remainder = n % divider;
        if (remainder >= i * 2) {
            count += i;
        } else if (remainder >= i) {
            count += remainder - i + 1;
        }
        i *= 10;
    }
    return count;
}