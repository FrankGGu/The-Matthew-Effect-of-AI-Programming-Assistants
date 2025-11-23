#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWays(char * s){
    long long n = 0;
    while (s[n] != '\0') {
        n++;
    }

    long long ones = 0;
    for (long long i = 0; i < n; i++) {
        if (s[i] == '1') {
            ones++;
        }
    }

    if (ones % 3 != 0) {
        return 0;
    }

    if (ones == 0) {
        long long mod = 1000000007;
        return ((n - 1) * (n - 2) / 2) % mod;
    }

    long long target = ones / 3;
    long long first = 0;
    long long second = 0;
    long long count = 0;

    for (long long i = 0; i < n; i++) {
        if (s[i] == '1') {
            count++;
        }
        if (count == target) {
            first++;
        }
        if (count == 2 * target) {
            second++;
        }
    }

    long long mod = 1000000007;
    return (first * second) % mod;
}