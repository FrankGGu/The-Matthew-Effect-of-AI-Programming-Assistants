char * lastSubstring(char * s) {
    int n = strlen(s);
    int i, j = 0, k = 1;
    for (i = 1; i < n; i++) {
        if (s[i] > s[j]) {
            j = i;
            k = i + 1;
        } else if (s[i] == s[j]) {
            while (k < n && s[k] == s[j]) k++;
            if (k < n && s[k] > s[j]) {
                j = i;
            }
        }
    }
    return s + j;
}