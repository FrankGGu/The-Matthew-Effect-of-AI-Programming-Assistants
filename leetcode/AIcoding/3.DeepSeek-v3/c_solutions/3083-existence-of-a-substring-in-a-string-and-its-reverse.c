bool isSubstringPresent(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n - 1; i++) {
        for (int j = n - 1; j > 0; j--) {
            if (s[i] == s[j] && s[i + 1] == s[j - 1]) {
                return true;
            }
        }
    }
    return false;
}