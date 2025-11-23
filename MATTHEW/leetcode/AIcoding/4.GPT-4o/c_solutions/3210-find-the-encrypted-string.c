char *encrypt(char *s) {
    int n = strlen(s);
    char *result = (char *)malloc(2 * n + 1);
    int index = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] >= 'A' && s[i] <= 'Z') {
            result[index++] = s[i];
        } else if (s[i] >= 'a' && s[i] <= 'z') {
            result[index++] = s[i] - 32;
        } else if (s[i] >= '0' && s[i] <= '9') {
            result[index++] = s[i];
        }
    }

    result[index] = '\0';
    return result;
}