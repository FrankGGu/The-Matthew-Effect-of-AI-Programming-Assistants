int countSubstrings(char * s, char c) {
    int count = 0, n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == c) {
            for (int j = i; j < n; j++) {
                if (s[j] == c) {
                    count++;
                }
            }
        }
    }
    return count;
}