#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int monkeyMove(int n) {
    int mod = 1000000007;
    long long result = 1;
    long long base = 2;
    long long exponent = n;

    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exponent /= 2;
    }

    return (int)(result - 1 + mod) % mod;
}