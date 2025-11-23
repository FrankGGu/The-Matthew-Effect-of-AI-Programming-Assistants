int appendCharacters(char *s, char *t) {
    int lenS = strlen(s), lenT = strlen(t);
    int j = 0;

    for (int i = 0; i < lenS && j < lenT; i++) {
        if (s[i] == t[j]) {
            j++;
        }
    }
    return lenT - j;
}