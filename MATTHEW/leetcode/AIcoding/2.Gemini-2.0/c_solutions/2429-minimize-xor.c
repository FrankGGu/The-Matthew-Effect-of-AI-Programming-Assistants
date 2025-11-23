#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeXor(int num1, int num2) {
    int bits2 = 0;
    int temp = num2;
    while (temp > 0) {
        bits2 += (temp & 1);
        temp >>= 1;
    }

    int result = 0;
    for (int i = 30; i >= 0 && bits2 > 0; i--) {
        if ((num1 >> i) & 1) {
            result |= (1 << i);
            bits2--;
        }
    }

    for (int i = 0; i <= 30 && bits2 > 0; i++) {
        if (!((result >> i) & 1)) {
            result |= (1 << i);
            bits2--;
        }
    }

    return result;
}