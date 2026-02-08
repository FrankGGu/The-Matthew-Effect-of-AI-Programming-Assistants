#define MOD 1000000007

long long modPow(long long base, int exp, int mod) {
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

int makeStringSorted(char* s) {
    int n = strlen(s);

    long long fact[3001];
    long long invFact[3001];
    fact[0] = 1;
    for (int i = 1; i <= 3000; i++) {
        fact[i] = (fact[i-1] * i) % MOD;
    }
    invFact[3000] = modPow(fact[3000], MOD-2, MOD);
    for (int i = 2999; i >= 0; i--) {
        invFact[i] = (invFact[i+1] * (i+1)) % MOD;
    }

    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    long long result = 0;
    for (int i = 0; i < n; i++) {
        int current = s[i] - 'a';

        long long totalPerm = fact[n - i - 1];
        for (int j = 0; j < 26; j++) {
            if (freq[j] > 0) {
                totalPerm = (totalPerm * invFact[freq[j]]) % MOD;
            }
        }

        for (int j = 0; j < current; j++) {
            if (freq[j] > 0) {
                long long perm = (totalPerm * freq[j]) % MOD;
                result = (result + perm) % MOD;
            }
        }

        freq[current]--;
    }

    return result;
}