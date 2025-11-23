char findKthCharacter(char *s, int k) {
    int len = strlen(s);
    int count = 0;
    while (1) {
        count += len;
        if (count >= k) break;
        len *= 2;
    }
    int idx = k - (count - strlen(s));
    while (idx > strlen(s)) {
        if (idx > strlen(s) + (idx - strlen(s)) / 2) {
            idx = idx - (strlen(s) + 1) / 2;
        } else {
            idx = idx - (strlen(s) + 1) / 2;
        }
    }
    return s[idx - 1];
}