#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int hammingWeight(uint32_t n) {
    int count = 0;
    while (n != 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}