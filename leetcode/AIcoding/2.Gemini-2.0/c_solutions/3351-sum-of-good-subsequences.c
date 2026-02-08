#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int stringToInt(char *s) {
    int res = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        res = res * 10 + (s[i] - '0');
    }
    return res;
}

int sumOfGoodSubsequences(char *num) {
    int n = strlen(num);
    long long ans = 0;
    long long pow2[n + 1];
    pow2[0] = 1;
    for (int i = 1; i <= n; i++) {
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }

    for (int i = 0; i < n; i++) {
        if (num[i] != '0') {
            char sub[n - i + 1];
            strncpy(sub, num + i, n - i);
            sub[n - i] = '\0';
            int val = stringToInt(sub);
            ans = (ans + val * pow2[n - i - 1]) % MOD;
        }
    }

    return (int)ans;
}