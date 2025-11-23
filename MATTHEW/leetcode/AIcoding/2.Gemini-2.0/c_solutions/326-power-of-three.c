#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPowerOfThree(int n) {
    if (n <= 0) {
        return false;
    }
    while (n % 3 == 0) {
        n /= 3;
    }
    return n == 1;
}