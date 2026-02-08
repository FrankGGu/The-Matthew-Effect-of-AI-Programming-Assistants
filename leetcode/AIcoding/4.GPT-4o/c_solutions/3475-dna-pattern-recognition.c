char * longestDupSubstring(char * s) {
    int n = strlen(s);
    int left = 1, right = n - 1, start = 0;
    int base = 256, mod = 1e9 + 7;

    while (left <= right) {
        int len = left + (right - left) / 2;
        long long hash = 0, seen = 0;
        long long baseL = 1;
        int found = 0;

        for (int i = 0; i < len; i++) {
            hash = (hash * base + s[i]) % mod;
            baseL = (baseL * base) % mod;
        }

        seen = (1LL << hash);
        for (int i = len; i < n; i++) {
            hash = (hash * base + s[i] - s[i - len] * baseL) % mod;
            if (hash < 0) hash += mod;
            if (seen & (1LL << hash)) {
                start = i - len + 1;
                found = 1;
                break;
            }
            seen |= (1LL << hash);
        }

        if (found) {
            left = len + 1;
        } else {
            right = len - 1;
        }
    }

    char *result = (char *)malloc((left) * sizeof(char));
    strncpy(result, s + start, left - 1);
    result[left - 1] = '\0';
    return result;
}