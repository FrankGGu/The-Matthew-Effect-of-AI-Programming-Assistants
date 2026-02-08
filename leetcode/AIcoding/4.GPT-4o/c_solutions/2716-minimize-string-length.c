int minimizeStringLength(char *s) {
    int charSet[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        charSet[s[i] - 'a'] = 1;
    }
    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (charSet[i]) {
            count++;
        }
    }
    return count;
}