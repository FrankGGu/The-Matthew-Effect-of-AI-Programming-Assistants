int countBalancedPermutations(char* word) {
    int freq[26] = {0};
    int n = strlen(word);
    for (int i = 0; i < n; i++) {
        freq[word[i] - 'a']++;
    }

    int odd_count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 == 1) {
            odd_count++;
        }
    }

    if (odd_count > 1) {
        return 0;
    }

    int half_len = n / 2;
    long long mod = 1000000007;

    long long fact[n + 1];
    fact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % mod;
    }

    long long inv_fact[n + 1];
    inv_fact[n] = pow_mod(fact[n], mod - 2, mod);
    for (int i = n - 1; i >= 0; i--) {
        inv_fact[i] = (inv_fact[i + 1] * (i + 1)) % mod;
    }

    long long denominator = 1;
    for (int i = 0; i < 26; i++) {
        denominator = (denominator * inv_fact[freq[i] / 2]) % mod;
    }

    long long total = (fact[half_len] * denominator) % mod;

    long long dp[half_len + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 0; i < 26; i++) {
        int cnt = freq[i] / 2;
        if (cnt == 0) continue;
        for (int j = half_len; j >= 0; j--) {
            for (int k = 1; k <= cnt; k++) {
                if (j + k <= half_len) {
                    dp[j + k] = (dp[j + k] + dp[j] * inv_fact[k] % mod) % mod;
                }
            }
        }
    }

    long long ways = dp[half_len] * fact[half_len] % mod;

    long long result = total * ways % mod;
    if (odd_count == 1) {
        result = result * n % mod;
    }

    return (int)result;
}

long long pow_mod(long long base, long long exp, long long mod) {
    long long result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}