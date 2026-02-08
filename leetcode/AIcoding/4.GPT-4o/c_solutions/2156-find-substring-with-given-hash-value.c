int subStrHash(char * s, int k, int hashValue, int power) {
    int n = strlen(s);
    long long currentHash = 0;
    long long p = 1;

    for (int i = n - 1; i >= n - k; i--) {
        currentHash = (currentHash + (s[i] - 'a' + 1) * p) % 1000000007;
        p = (p * power) % 1000000007;
    }

    if (currentHash == hashValue) return n - k;

    for (int i = n - k; i >= 0; i--) {
        currentHash = (currentHash - (s[i + k] - 'a' + 1) * p + 1000000007) % 1000000007;
        currentHash = (currentHash * power) % 1000000007;
        currentHash = (currentHash + (s[i] - 'a' + 1)) % 1000000007;

        if (currentHash == hashValue) return i;
    }

    return -1;
}