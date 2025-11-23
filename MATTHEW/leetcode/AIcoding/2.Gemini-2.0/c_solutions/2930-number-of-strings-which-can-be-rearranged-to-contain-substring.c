#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int stringCount(int n) {
    if (n < 3) return 0;
    int64_t total = 1;
    for (int i = 0; i < n; i++) {
        total = (total * 26) % MOD;
    }

    int64_t no_a = 1;
    for (int i = 0; i < n; i++) {
        no_a = (no_a * 25) % MOD;
    }

    int64_t no_l = 1;
    for (int i = 0; i < n; i++) {
        no_l = (no_l * 25) % MOD;
    }

    int64_t no_e = 1;
    for (int i = 0; i < n; i++) {
        no_e = (no_e * 25) % MOD;
    }

    int64_t no_al = 1;
    for (int i = 0; i < n; i++) {
        no_al = (no_al * 24) % MOD;
    }

    int64_t no_ae = 1;
    for (int i = 0; i < n; i++) {
        no_ae = (no_ae * 24) % MOD;
    }

    int64_t no_le = 1;
    for (int i = 0; i < n; i++) {
        no_le = (no_le * 24) % MOD;
    }

    int64_t no_ale = 1;
    for (int i = 0; i < n; i++) {
        no_ale = (no_ale * 23) % MOD;
    }

    int64_t ans = (total - no_a - no_l - no_e + no_al + no_ae + no_le - no_ale) % MOD;
    if (ans < 0) ans += MOD;
    return (int)ans;
}