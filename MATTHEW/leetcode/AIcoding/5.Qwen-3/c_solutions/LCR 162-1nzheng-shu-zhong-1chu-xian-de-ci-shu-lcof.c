#include <stdio.h>
#include <stdlib.h>

int countDigitOne(int n) {
    int count = 0;
    long i = 1;
    while (i <= n) {
        long divider = i * 10;
        count += (n / divider) * i;
        if (n % divider >= i * 2) {
            count += i;
        } else if (n % divider >= i) {
            count += n % divider - i + 1;
        }
        i *= 10;
    }
    return count;
}