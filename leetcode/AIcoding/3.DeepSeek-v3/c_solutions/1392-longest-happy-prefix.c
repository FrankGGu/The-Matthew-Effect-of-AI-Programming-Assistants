char* longestPrefix(char* s) {
    int n = strlen(s);
    int* lps = (int*)malloc(n * sizeof(int));
    lps[0] = 0;
    int len = 0;
    int i = 1;

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

    int length = lps[n - 1];
    char* result = (char*)malloc((length + 1) * sizeof(char));
    strncpy(result, s, length);
    result[length] = '\0';
    free(lps);
    return result;
}