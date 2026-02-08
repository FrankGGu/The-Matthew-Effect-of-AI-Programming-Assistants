#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numUniqueGoodSubsequences(char* s) {
    int mod = 1000000007;
    int a = 0, b = 0, c = 0;
    int has0 = 0, has1 = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '0') {
            has0 = 1;
            a = (a + b + 1) % mod;
        } else {
            has1 = 1;
            b = (b + a + 1) % mod;
        }
    }
    return (a + b) % mod;
}