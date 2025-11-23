char *finalString(char *s) {
    int len = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '#') {
            if (len > 0) len--;
        } else {
            s[len++] = s[i];
        }
    }
    s[len] = '\0';
    return s;
}