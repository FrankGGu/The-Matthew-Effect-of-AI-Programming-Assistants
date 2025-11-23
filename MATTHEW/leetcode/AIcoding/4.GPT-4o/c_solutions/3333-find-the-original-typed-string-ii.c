char *findOriginalString(char *s) {
    int len = strlen(s);
    char *result = (char *)malloc(len + 1);
    int j = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '#') {
            if (j > 0) j--;
        } else {
            result[j++] = s[i];
        }
    }
    result[j] = '\0';
    return result;
}