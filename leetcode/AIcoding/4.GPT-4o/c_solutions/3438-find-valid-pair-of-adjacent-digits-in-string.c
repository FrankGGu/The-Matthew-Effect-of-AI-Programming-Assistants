bool hasValidPair(char *s) {
    int len = strlen(s);
    for (int i = 0; i < len - 1; i++) {
        if (s[i] == s[i + 1]) {
            return true;
        }
    }
    return false;
}