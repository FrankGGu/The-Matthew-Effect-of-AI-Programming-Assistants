#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countSpecialSubsequences(char *s) {
    int a = 0, b = 0, c = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == 'a') {
            a = (a + 1) % MOD;
        } else if (s[i] == 'b') {
            b = (b + a) % MOD;
        } else if (s[i] == 'c') {
            c = (c + b) % MOD;
        }
    }
    return c;
}