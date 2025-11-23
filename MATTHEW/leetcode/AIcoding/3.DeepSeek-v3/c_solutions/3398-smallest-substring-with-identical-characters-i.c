int minLength(char* s) {
    int n = strlen(s);
    int min_len = n;

    for (int i = 0; i < n; i++) {
        int j = i;
        while (j < n && s[j] == s[i]) {
            j++;
        }
        int len = j - i;
        if (len > 1 && len < min_len) {
            min_len = len;
        }
        i = j - 1;
    }

    return min_len == n ? -1 : min_len;
}