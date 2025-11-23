char * shortestPalindrome(char * s) {
    int len = strlen(s);
    if (len == 0) return "";

    char *rev = (char *)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        rev[i] = s[len - 1 - i];
    }
    rev[len] = '\0';

    for (int i = len; i > 0; i--) {
        if (strncmp(s, rev + (len - i), i) == 0) {
            char *result = (char *)malloc((len + len - i + 1) * sizeof(char));
            strcpy(result, rev);
            strcat(result, s + i);
            free(rev);
            return result;
        }
    }

    free(rev);
    char *result = (char *)malloc((len + 1) * sizeof(char));
    strcpy(result, rev);
    strcat(result, s + 1);
    return result;
}