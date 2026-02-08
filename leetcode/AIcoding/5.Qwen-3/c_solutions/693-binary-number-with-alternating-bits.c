#include <stdio.h>
#include <stdlib.h>

bool hasAlternatingBits(int n) {
    int prev = n & 1;
    n >>= 1;
    while (n) {
        int current = n & 1;
        if (current == prev) {
            return false;
        }
        prev = current;
        n >>= 1;
    }
    return true;
}