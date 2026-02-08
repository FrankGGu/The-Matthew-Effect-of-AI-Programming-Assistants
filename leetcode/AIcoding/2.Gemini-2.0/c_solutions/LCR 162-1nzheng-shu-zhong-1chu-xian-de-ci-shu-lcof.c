#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDigitOne(int n) {
    int count = 0;
    long long i = 1;
    while (n / i != 0) {
        long long high = n / (i * 10);
        long long cur = (n / i) % 10;
        long long low = n - (n / i) * i;

        if (cur == 0) {
            count += high * i;
        } else if (cur == 1) {
            count += high * i + low + 1;
        } else {
            count += (high + 1) * i;
        }
        i *= 10;
    }
    return count;
}