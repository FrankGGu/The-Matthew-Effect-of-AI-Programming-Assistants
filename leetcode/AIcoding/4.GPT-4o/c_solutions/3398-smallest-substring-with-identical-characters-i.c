char *smallestSubstring(char *s) {
    int n = strlen(s);
    int min_len = n + 1;
    char *result = NULL;

    for (int i = 0; i < n; i++) {
        int j = i + 1;
        while (j < n && s[j] == s[i]) {
            j++;
        }
        int len = j - i;
        if (len < min_len) {
            min_len = len;
            result = (char *)malloc((len + 1) * sizeof(char));
            strncpy(result, s + i, len);
            result[len] = '\0';
        }
        i = j - 1;
    }

    return result;
}