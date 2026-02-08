int hasSpecialSubstring(char* s, int k) {
    int n = strlen(s);
    for (int i = 0; i <= n - k; i++) {
        int valid = 1;
        char first = s[i];
        for (int j = i + 1; j < i + k; j++) {
            if (s[j] != first) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            if (i > 0 && s[i-1] == first) continue;
            if (i + k < n && s[i+k] == first) continue;
            return 1;
        }
    }
    return 0;
}