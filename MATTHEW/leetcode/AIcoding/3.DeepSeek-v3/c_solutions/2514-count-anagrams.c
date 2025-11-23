#include <string.h>
#include <stdlib.h>

#define MOD 1000000007

long long mod_pow(long long base, long long exp, long long mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

int countAnagrams(char* s) {
    int len = strlen(s);
    long long result = 1;

    long long fact[100001];
    long long inv_fact[100001];

    fact[0] = 1;
    for (int i = 1; i <= 100000; i++) {
        fact[i] = (fact[i-1] * i) % MOD;
    }

    inv_fact[100000] = mod_pow(fact[100000], MOD-2, MOD);
    for (int i = 99999; i >= 0; i--) {
        inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD;
    }

    char* token = strtok(s, " ");
    while (token != NULL) {
        int word_len = strlen(token);
        int freq[26] = {0};

        for (int i = 0; i < word_len; i++) {
            freq[token[i] - 'a']++;
        }

        long long ways = fact[word_len];
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 1) {
                ways = (ways * inv_fact[freq[i]]) % MOD;
            }
        }

        result = (result * ways) % MOD;
        token = strtok(NULL, " ");
    }

    return result;
}