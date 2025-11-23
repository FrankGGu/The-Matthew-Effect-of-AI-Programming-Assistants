char *reverseWords(char *s) {
    int len = strlen(s);
    char *result = (char *)malloc(len + 1);
    int j = 0;

    for (int i = len - 1; i >= 0; i--) {
        if (s[i] != ' ') {
            if (j > 0) result[j++] = ' ';
            int start = i;
            while (i >= 0 && s[i] != ' ') i--;
            for (int k = i + 1; k <= start; k++) {
                result[j++] = s[k];
            }
        }
    }

    result[j] = '\0';
    return result;
}