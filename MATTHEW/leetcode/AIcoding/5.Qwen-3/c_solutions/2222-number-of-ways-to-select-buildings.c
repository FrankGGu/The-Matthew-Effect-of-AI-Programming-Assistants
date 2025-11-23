#include <stdio.h>
#include <stdlib.h>

long long numberOfWays(int* s, int sSize) {
    long long count0 = 0, count1 = 0;
    long long total = 0;
    for (int i = 0; i < sSize; i++) {
        if (s[i] == 0) {
            count0++;
        } else {
            count1++;
        }
    }
    long long zeros = 0, ones = 0;
    for (int i = 0; i < sSize; i++) {
        if (s[i] == 0) {
            zeros++;
            total += ones * (count1 - ones);
        } else {
            ones++;
            total += zeros * (count0 - zeros);
        }
    }
    return total;
}