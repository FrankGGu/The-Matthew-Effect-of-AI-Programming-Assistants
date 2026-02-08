#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodNumbers(long long n) {
    long long mod = 1000000007;
    long long even = (n + 1) / 2;
    long long odd = n / 2;
    long long ans = 1;
    long long baseEven = 5;
    long long baseOdd = 4;

    while (even > 0) {
        if (even % 2 == 1) {
            ans = (ans * baseEven) % mod;
        }
        baseEven = (baseEven * baseEven) % mod;
        even /= 2;
    }

    while (odd > 0) {
        if (odd % 2 == 1) {
            ans = (ans * baseOdd) % mod;
        }
        baseOdd = (baseOdd * baseOdd) % mod;
        odd /= 2;
    }

    return (int)ans;
}