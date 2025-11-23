#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countVowelPermutation(int n) {
    long long a = 1, e = 1, i = 1, o = 1, u = 1;
    long long mod = 1000000007;
    long long a_new, e_new, i_new, o_new, u_new;

    for (int k = 1; k < n; k++) {
        a_new = (e + i + u) % mod;
        e_new = (a + i) % mod;
        i_new = (e + o) % mod;
        o_new = i % mod;
        u_new = (i + o) % mod;

        a = a_new;
        e = e_new;
        i = i_new;
        o = o_new;
        u = u_new;
    }

    return (int)((a + e + i + o + u) % mod);
}