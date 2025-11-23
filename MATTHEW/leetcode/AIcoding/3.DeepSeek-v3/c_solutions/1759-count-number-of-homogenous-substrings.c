int countHomogenous(char* s) {
    long long count = 0;
    long long mod = 1000000007;
    int len = strlen(s);
    long long consecutive = 1;

    for (int i = 1; i <= len; i++) {
        if (i < len && s[i] == s[i-1]) {
            consecutive++;
        } else {
            count = (count + (consecutive * (consecutive + 1) / 2) % mod) % mod;
            consecutive = 1;
        }
    }

    return (int)count;
}