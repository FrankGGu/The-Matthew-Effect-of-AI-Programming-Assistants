#include <stdio.h>
#include <stdlib.h>

int bitwiseComplement(int N) {
    if (N == 0) return 1;
    int mask = 1;
    while (mask < N) {
        mask = (mask << 1) | 1;
    }
    return N ^ mask;
}