bool canMakeSubsequence(char *s, char *t) {
    int n = strlen(s), m = strlen(t);
    int j = 0;

    for (int i = 0; i < n && j < m; i++) {
        if (s[i] <= t[j]) {
            j++;
        }
    }

    return j == m;
}