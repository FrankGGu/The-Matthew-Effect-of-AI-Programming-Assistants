int countSubstrings(char * s, char * t) {
    int m = strlen(s), n = strlen(t), count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int diff = 0;
            for (int k = 0; k < fmin(m - i, n - j); k++) {
                if (s[i + k] != t[j + k]) {
                    diff++;
                }
                if (diff > 1) break;
                if (diff == 1) count++;
            }
        }
    }
    return count;
}