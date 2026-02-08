char* longestSpecialSubstring(char* s) {
    int n = strlen(s);
    int maxLength = 0;
    char* result = "";

    for (int len = 1; len <= n / 3; len++) {
        for (int i = 0; i <= n - len; i++) {
            char* substring = strndup(s + i, len);
            int count = 0;
            for (int j = 0; j <= n - len; j++) {
                if (strncmp(s + j, substring, len) == 0) {
                    count++;
                }
            }
            if (count == 3) {
                if (len > maxLength) {
                    maxLength = len;
                    result = substring;
                }
            }
            free(substring);
        }
    }

    return maxLength > 0 ? result : "";
}