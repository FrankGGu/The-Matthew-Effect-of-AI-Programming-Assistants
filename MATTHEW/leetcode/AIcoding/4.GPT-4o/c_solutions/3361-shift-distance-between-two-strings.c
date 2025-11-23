int shiftDistance(char *s, char *t) {
    int n = strlen(s);
    if (n != strlen(t)) return -1;

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] != t[i]) {
            count++;
        }
    }

    return count;
}