#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int bitwiseComplement(int n) {
    if (n == 0) return 1;
    int x = 1;
    while (x <= n) {
        x = x << 1;
    }
    return (x - 1) ^ n;
}