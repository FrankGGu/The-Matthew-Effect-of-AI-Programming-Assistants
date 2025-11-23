char *minimumValue(char *s) {
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '?') {
            if (i == 0) {
                s[i] = '1';
            } else {
                s[i] = '0';
            }
        }
    }
    return s;
}