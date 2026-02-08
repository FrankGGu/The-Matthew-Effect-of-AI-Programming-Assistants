#include <stdio.h>
#include <stdlib.h>

int superPow(int a, int b[], int length) {
    int mod = 1000000007;
    int result = 1;
    for (int i = 0; i < length; i++) {
        result = (pow(result, 10) * pow(a, b[i])) % mod;
    }
    return result;
}

int pow(int base, int exponent) {
    int result = 1;
    int mod = 1000000007;
    base = base % mod;
    while (exponent > 0) {
        if (exponent % 2 == 1)
            result = (result * base) % mod;
        base = (base * base) % mod;
        exponent = exponent / 2;
    }
    return result;
}