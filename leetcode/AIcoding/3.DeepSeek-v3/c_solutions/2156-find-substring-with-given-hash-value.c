long long power(long long base, int exp, int mod) {
    long long result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1)
            result = (result * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

char* subStrHash(char* s, int power, int modulo, int k, int hashValue) {
    int n = strlen(s);
    long long hash = 0;
    long long p = power;
    long long mod = modulo;

    long long max_power = power(p, k - 1, mod);

    int pos = n;
    for (int i = n - 1; i >= 0; i--) {
        int val = s[i] - 'a' + 1;

        if (i + k < n) {
            int remove_val = s[i + k] - 'a' + 1;
            hash = (hash - (remove_val * max_power) % mod + mod) % mod;
        }

        hash = (hash * p + val) % mod;

        if (i <= n - k && hash == hashValue) {
            pos = i;
        }
    }

    char* result = (char*)malloc((k + 1) * sizeof(char));
    strncpy(result, s + pos, k);
    result[k] = '\0';
    return result;
}