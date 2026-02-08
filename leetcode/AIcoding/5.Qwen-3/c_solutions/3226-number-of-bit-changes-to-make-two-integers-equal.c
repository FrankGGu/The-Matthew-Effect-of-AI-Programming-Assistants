#include <stdio.h>
#include <stdlib.h>

int minBitChanges(int n, int m) {
    int xor = n ^ m;
    int count = 0;
    while (xor) {
        count += xor & 1;
        xor >>= 1;
    }
    return count;
}