#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int concatenatedBinary(int n){
    long long mod = 1e9 + 7;
    long long ans = 0;
    int len = 0;
    for (int i = 1; i <= n; i++) {
        if ((i & (i - 1)) == 0) {
            len++;
        }
        ans = ((ans << len) % mod + i) % mod;
    }
    return (int)ans;
}