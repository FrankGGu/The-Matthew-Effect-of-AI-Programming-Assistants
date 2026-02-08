#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findComplement(int num) {
    int mask = 0;
    int temp = num;
    while (temp > 0) {
        mask = (mask << 1) | 1;
        temp >>= 1;
    }
    return num ^ mask;
}