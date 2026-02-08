#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BASE 256
#define MOD 1000000007

typedef struct {
    char* str;
    int length;
} Substring;

int rabinKarp(char *s, int len, long long *hashes, long long *powers) {
    long long hash = 0;
    for (int i = 0; i < len; i++) {
        hash = (hash * BASE + s[i]) % MOD;
    }
    hashes[0] = hash;

    for (int i = 1; i < s.length - len + 1; i++) {
        hash = (hash * BASE - s[i - 1] * powers[len] % MOD + MOD) % MOD;
        hash = (hash + s[i + len - 1]) % MOD;
        hashes[i] = hash;
    }

    return hash;
}

Substring longestDupSubstring(char *s) {
    int n = strlen(s);
    long long *hashes = (long long *)malloc((n + 1) * sizeof(long long));
    long long *powers = (long long *)malloc((n + 1) * sizeof(long long));
    powers[0] = 1;

    for (int i = 1; i <= n; i++) {
        powers[i] = (powers[i - 1] * BASE) % MOD;
    }

    int left = 1, right = n, len = 0;
    Substring result = {NULL, 0};

    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long seen[MOD] = {0};
        long long hash = rabinKarp(s, mid, hashes, powers);
        int found = 0;

        for (int i = 0; i <= n - mid; i++) {
            if (seen[hash]) {
                found = 1;
                result.length = mid;
                result.str = (char *)malloc((mid + 1) * sizeof(char));
                strncpy(result.str, s + i, mid);
                result.str[mid] = '\0';
                break;
            }
            seen[hash] = 1;
            if (i < n - mid) {
                hash = (hash * BASE - s[i] * powers[mid] % MOD + MOD) % MOD;
                hash = (hash + s[i + mid]) % MOD;
            }
        }

        if (found) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    free(hashes);
    free(powers);
    return result;
}