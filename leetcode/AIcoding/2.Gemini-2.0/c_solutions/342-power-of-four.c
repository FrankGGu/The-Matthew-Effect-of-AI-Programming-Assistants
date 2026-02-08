#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPowerOfFour(int n) {
    if (n <= 0) return false;
    if ((n & (n - 1)) != 0) return false;
    return (n & 0x55555555) != 0;
}