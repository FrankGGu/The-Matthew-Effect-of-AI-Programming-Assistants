char *finalString(char *s) {
    int len = 0, i = 0;
    for (i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'i') {
            len = (len > 0) ? len - 1 : 0;
        } else {
            len++;
        }
    }

    char *result = malloc(len + 1);
    int j = len - 1;
    for (i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'i') {
            if (j >= 0) j--;
        } else {
            result[j--] = s[i];
        }
    }
    result[len] = '\0';
    return result;
}