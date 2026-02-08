#include <string.h>

long long fact[3001];
long long invFact[3001];
int MOD = 1e9 + 7;

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

void precompute_factorials(int n) {
    fact[0] = 1;
    invFact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        invFact[i] = power(fact[i], MOD - 2);
    }
}

int minimumOperations(char * s){
    int n = strlen(s);

    static int precomputed_max_n = 0;
    if (precomputed_max_n == 0) { 
        precompute_factorials(3000); 
        precomputed_max_n = 3000;
    }

    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    long long ans = 0;
    long long current_denom_inv = 1; 
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            current_denom_inv = (current_denom_inv * invFact[freq[i]]) % MOD;
        }
    }

    for (int i = 0; i < n; i++) {
        int char_val = s[i] - 'a';

        for (int j = 0; j < char_val; j++) {
            if (freq[j] > 0) {
                long long term = fact[n - 1 - i];
                term = (term * current_denom_inv) % MOD;
                term = (term * freq[j]) % MOD; 
                ans = (ans + term) % MOD;
            }
        }

        current_denom_inv = (current_denom_inv * freq[char_val]) % MOD;
        freq[char_val]--;
    }

    return (int)ans;
}