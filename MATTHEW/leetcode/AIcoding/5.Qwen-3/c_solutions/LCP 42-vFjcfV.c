#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int findIntegersWithNZeroes(int n) {
    int count = 0;
    for (int i = 1; i <= (1 << n); i++) {
        int bits = 0;
        int num = i;
        while (num > 0) {
            if (num & 1) bits++;
            num >>= 1;
        }
        if (bits == n) count++;
    }
    return count;
}

int findIntegers(int n, int k) {
    int count = 0;
    for (int i = 1; i <= (1 << n); i++) {
        int bits = 0;
        int num = i;
        while (num > 0) {
            if (num & 1) bits++;
            num >>= 1;
        }
        if (bits == k) count++;
    }
    return count;
}