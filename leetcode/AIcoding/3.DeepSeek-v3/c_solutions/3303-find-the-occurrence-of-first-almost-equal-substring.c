int min(int a, int b) {
    return a < b ? a : b;
}

int findFirstOccurrence(char* s, char* pattern) {
    int n = strlen(s);
    int m = strlen(pattern);

    for (int i = 0; i <= n - m; i++) {
        int diff = 0;
        for (int j = 0; j < m; j++) {
            if (s[i + j] != pattern[j]) {
                diff++;
                if (diff > 1) break;
            }
        }
        if (diff <= 1) {
            return i;
        }
    }
    return -1;
}