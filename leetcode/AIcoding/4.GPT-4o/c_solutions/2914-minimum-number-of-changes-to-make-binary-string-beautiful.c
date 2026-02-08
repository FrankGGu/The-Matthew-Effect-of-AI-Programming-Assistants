int minimumChanges(char *s) {
    int n = strlen(s);
    int changes = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            if (i > 0 && s[i - 1] == '0') changes++;
            if (i < n - 1 && s[i + 1] == '0') changes++;
        }
    }

    return (changes + 1) / 2;
}