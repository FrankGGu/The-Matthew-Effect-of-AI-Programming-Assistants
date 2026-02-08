char *makeFancyString(char *s) {
    int len = 0, count = 1;
    char *result = (char *)malloc((strlen(s) + 1) * sizeof(char));
    result[0] = s[0];
    len = 1;

    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i - 1]) {
            count++;
        } else {
            count = 1;
        }
        if (count < 3) {
            result[len++] = s[i];
        }
    }
    result[len] = '\0';
    return result;
}