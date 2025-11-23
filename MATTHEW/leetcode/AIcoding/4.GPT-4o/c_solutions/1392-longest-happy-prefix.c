char* longestPrefix(char* s) {
    int n = strlen(s);
    int* lps = (int*)malloc(n * sizeof(int));
    int len = 0, i = 1;

    while (i < n) {
        if (s[i] == s[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    int prefixLength = lps[n - 1];
    free(lps);

    char* result = (char*)malloc((prefixLength + 1) * sizeof(char));
    strncpy(result, s, prefixLength);
    result[prefixLength] = '\0';

    return result;
}