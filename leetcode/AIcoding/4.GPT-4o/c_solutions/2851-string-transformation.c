char *transformString(char *s, char *t) {
    int count[256] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i]]++;
    }
    for (int i = 0; t[i] != '\0'; i++) {
        count[t[i]]--;
    }
    for (int i = 0; i < 256; i++) {
        if (count[i] != 0) return "NO";
    }
    return "YES";
}