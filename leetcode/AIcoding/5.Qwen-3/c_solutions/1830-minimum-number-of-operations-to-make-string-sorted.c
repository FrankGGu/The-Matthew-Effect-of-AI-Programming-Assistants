#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long fact(int n) {
    long long res = 1;
    for (int i = 2; i <= n; i++) {
        res *= i;
    }
    return res;
}

long long modinv(long long a, long long m) {
    long long g, x, y;
    g = gcd(a, m, &x, &y);
    if (g != 1) return -1;
    else return (x % m + m) % m;
}

long long gcd(long long a, long long b, long long *x, long long *y) {
    if (a == 0) {
        *x = 0;
        *y = 1;
        return b;
    }
    long long x1, y1;
    long long g = gcd(b % a, a, &x1, &y1);
    *x = y1 - (b / a) * x1;
    *y = x1;
    return g;
}

long long countOperations(char *s) {
    int n = strlen(s);
    long long result = 0;
    long long MOD = 1000000007;

    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    long long total = fact(n);
    for (int i = 0; i < n; i++) {
        long long cnt = 0;
        for (int j = 0; j < s[i] - 'a'; j++) {
            if (freq[j] > 0) {
                cnt += fact(n - i - 1);
            }
        }

        long long denom = 1;
        for (int j = 0; j < 26; j++) {
            if (freq[j] > 0) {
                denom *= fact(freq[j]);
            }
        }

        long long inv_denom = modinv(denom, MOD);
        result = (result + (cnt * inv_denom) % MOD) % MOD;

        freq[s[i] - 'a']--;
        total = (total * modinv(fact(1), MOD)) % MOD;
    }

    return result;
}