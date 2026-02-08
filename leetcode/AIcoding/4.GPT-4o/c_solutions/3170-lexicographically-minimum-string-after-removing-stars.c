char *removeStars(char *s) {
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    int j = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            if (j > 0) {
                j--;
            }
        } else {
            result[j++] = s[i];
        }
    }
    result[j] = '\0';
    return result;
}