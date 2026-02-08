#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPowerOfTwo(int n) {
    if (n <= 0) {
        return false;
    }
    return (n & (n - 1)) == 0;
}