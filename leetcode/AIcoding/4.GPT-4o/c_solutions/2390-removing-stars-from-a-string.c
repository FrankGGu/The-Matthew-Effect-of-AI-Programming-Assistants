char *removeStars(char *s) {
    int length = strlen(s);
    char *result = (char *)malloc(length + 1);
    int j = 0;

    for (int i = 0; i < length; i++) {
        if (s[i] == '*') {
            if (j > 0) j--;
        } else {
            result[j++] = s[i];
        }
    }

    result[j] = '\0';
    return result;
}