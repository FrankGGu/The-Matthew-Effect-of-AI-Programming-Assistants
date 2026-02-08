bool fuzzySearch(char *s1, char *s2) {
    int n = strlen(s1), m = strlen(s2);
    int j = 0;
    for (int i = 0; i < n && j < m; i++) {
        if (s1[i] == s2[j]) {
            j++;
        }
    }
    return j == m;
}