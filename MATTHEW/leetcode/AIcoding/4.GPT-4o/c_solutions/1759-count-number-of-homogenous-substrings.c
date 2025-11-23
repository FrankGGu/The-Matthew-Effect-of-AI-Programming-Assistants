int countHomogenous(char * s) {
    long long count = 0, result = 0;
    int mod = 1e9 + 7;

    for (int i = 0; s[i] != '\0'; i++) {
        if (i > 0 && s[i] == s[i - 1]) {
            count++;
        } else {
            count = 1;
        }
        result = (result + count) % mod;
    }

    return (int)result;
}