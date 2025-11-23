#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int peopleAwareOfSecret(int n, int delay, int forget) {
    long long aware[n + 1];
    long long sharing[n + 1];
    long long mod = 1e9 + 7;

    for (int i = 0; i <= n; i++) {
        aware[i] = 0;
        sharing[i] = 0;
    }

    aware[1] = 1;
    sharing[1] = 0;

    for (int i = 1; i < n; i++) {
        sharing[i + 1] = (sharing[i + 1] + aware[i]) % mod;
        for (int j = i + delay; j <= n && j < i + forget; j++) {
            aware[j] = (aware[j] + sharing[i + 1]) % mod;
        }
        sharing[i+1] = 0;
    }

    long long ans = 0;
    for (int i = n - forget + 1; i <= n; i++) {
        ans = (ans + aware[i]) % mod;
    }

    return (int)ans;
}