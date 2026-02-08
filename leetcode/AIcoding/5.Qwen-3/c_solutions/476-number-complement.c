#include <stdio.h>
#include <stdlib.h>

int findComplement(int num) {
    int mask = 0;
    while (mask < num) {
        mask = (mask << 1) | 1;
    }
    return num ^ mask;
}