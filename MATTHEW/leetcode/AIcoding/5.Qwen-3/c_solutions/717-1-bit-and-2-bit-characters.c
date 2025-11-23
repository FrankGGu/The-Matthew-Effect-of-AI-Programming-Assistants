#include <stdio.h>
#include <stdlib.h>

bool hasAlternatingBits(int n) {
    int prev = -1;
    while (n > 0) {
        int current = n & 1;
        if (current == prev) {
            return false;
        }
        prev = current;
        n >>= 1;
    }
    return true;
}