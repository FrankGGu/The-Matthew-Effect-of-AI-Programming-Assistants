int countHomogenous(char * s){
    long long total_count = 0;
    long long current_len = 0;
    long long MOD = 1000000007;

    if (s == NULL || *s == '\0') {
        return 0;
    }

    current_len = 1;

    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i-1]) {
            current_len++;
        } else {
            total_count = (total_count + (current_len * (current_len + 1) / 2)) % MOD;
            current_len = 1;
        }
    }

    total_count = (total_count + (current_len * (current_len + 1) / 2)) % MOD;

    return (int)total_count;
}