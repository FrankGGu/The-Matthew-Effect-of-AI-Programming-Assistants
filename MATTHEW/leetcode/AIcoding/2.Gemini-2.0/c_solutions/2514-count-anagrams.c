#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

int countAnagrams(char * s) {
    int n = strlen(s);
    long long ans = 1;
    long long fact[n + 1];
    fact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    char *words[n];
    int wordCount = 0;
    char *token = strtok(s, " ");
    while (token != NULL) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }

    for (int i = 0; i < wordCount; i++) {
        int len = strlen(words[i]);
        ans = (ans * fact[len]) % MOD;

        int count[26] = {0};
        for (int j = 0; j < len; j++) {
            count[words[i][j] - 'a']++;
        }

        for (int j = 0; j < 26; j++) {
            if (count[j] > 1) {
                ans = (ans * modInverse(fact[count[j]])) % MOD;
            }
        }
    }

    long long totalPermutations = fact[wordCount-1];

    return (int)ans;
}