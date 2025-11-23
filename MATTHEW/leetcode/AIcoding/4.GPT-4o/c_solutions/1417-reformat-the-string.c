char *reformat(char *s) {
    int n = strlen(s);
    char *letters = (char *)malloc(n + 1);
    char *digits = (char *)malloc(n + 1);
    int l = 0, d = 0;

    for (int i = 0; i < n; i++) {
        if (isalpha(s[i])) {
            letters[l++] = s[i];
        } else {
            digits[d++] = s[i];
        }
    }
    letters[l] = '\0';
    digits[d] = '\0';

    if (abs(l - d) > 1) {
        free(letters);
        free(digits);
        return "";
    }

    char *result = (char *)malloc(n + 1);
    int i = 0, j = 0, k = 0;

    while (i < l || j < d) {
        if (l >= d) {
            if (i < l) result[k++] = letters[i++];
            if (j < d) result[k++] = digits[j++];
        } else {
            if (j < d) result[k++] = digits[j++];
            if (i < l) result[k++] = letters[i++];
        }
    }
    result[k] = '\0';

    free(letters);
    free(digits);
    return result;
}