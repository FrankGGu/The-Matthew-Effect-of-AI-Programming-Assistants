long long appealSum(char* s) {
    long long res = 0;
    int last[26];
    memset(last, -1, sizeof(last));
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        last[s[i] - 'a'] = i;
        for (int j = 0; j < 26; j++) {
            if (last[j] != -1) {
                res += last[j] + 1;
            }
        }
    }

    return res;
}