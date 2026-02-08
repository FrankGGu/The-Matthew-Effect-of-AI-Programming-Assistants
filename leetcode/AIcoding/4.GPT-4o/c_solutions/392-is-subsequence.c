bool isSubsequence(char * s, char * t) {
    int m = strlen(s), n = strlen(t);
    int j = 0;

    for (int i = 0; i < n && j < m; i++) {
        if (t[i] == s[j]) {
            j++;
        }
    }

    return j == m;
}