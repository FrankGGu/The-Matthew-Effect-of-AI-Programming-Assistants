#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniqueGoodSubsequences(char *binary) {
    int n = strlen(binary);
    long long end_with_0 = 0;
    long long end_with_1 = 0;
    long long mod = 1000000007;
    int has_zero = 0;

    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            end_with_0 = (end_with_1 + end_with_0 + 1) % mod;
            has_zero = 1;
        } else {
            end_with_1 = (end_with_1 + end_with_0 + 1) % mod;
        }
    }

    if (has_zero) {
        return (end_with_0 + end_with_1) % mod;
    } else {
        return (end_with_1) % mod;
    }
}