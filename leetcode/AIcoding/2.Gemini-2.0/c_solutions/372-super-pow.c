#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int superPow(int a, int* b, int bSize) {
    int res = 1;
    a %= 1337;
    for (int i = 0; i < bSize; i++) {
        res = powMod(res, 10, 1337) * powMod(a, b[i], 1337) % 1337;
    }
    return res;
}

int powMod(int a, int k, int mod) {
    int res = 1;
    a %= mod;
    for (int i = 0; i < k; i++) {
        res = (res * a) % mod;
    }
    return res;
}