#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countOrders(int n) {
    long long ans = 1;
    for (int i = 1; i <= n; i++) {
        ans = (ans * i) % MOD;
        ans = (ans * (2 * i - 1)) % MOD;
    }
    return (int)ans;
}