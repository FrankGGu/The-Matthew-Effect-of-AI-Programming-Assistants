#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long factorial[100001];
long long inv_factorial[100001];

long long mod_inverse(long long a, long long p) {
    long long res = 1;
    long long exp = p - 2;
    while (exp) {
        if (exp % 2) res = (res * a) % p;
        a = (a * a) % p;
        exp /= 2;
    }
    return res;
}

void precompute_factorials(int n) {
    factorial[0] = 1;
    for (int i = 1; i <= n; i++) {
        factorial[i] = (factorial[i - 1] * i) % MOD;
    }
    for (int i = 0; i <= n; i++) {
        inv_factorial[i] = mod_inverse(factorial[i], MOD);
    }
}

long long count_anagrams(char *s) {
    int count[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }
    long long result = factorial[len];
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            result = (result * inv_factorial[count[i]]) % MOD;
        }
    }
    return result;
}

int countAnagrams(char **words, int wordsSize) {
    precompute_factorials(100000);
    long long total_count = 1;
    for (int i = 0; i < wordsSize; i++) {
        total_count = (total_count * count_anagrams(words[i])) % MOD;
    }
    return (int)total_count;
}