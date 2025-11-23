char* findLongestSpecialSubstring(char* s) {
    int n = strlen(s);
    char* result = "";
    int maxLength = 0;

    for (int len = 1; len <= n / 3; len++) {
        for (int i = 0; i <= n - len; i++) {
            char* substr = strndup(s + i, len);
            int count = 0;
            for (int j = 0; j <= n - len; j++) {
                if (strncmp(s + j, substr, len) == 0) {
                    count++;
                }
            }
            if (count == 3 && len > maxLength) {
                maxLength = len;
                result = substr;
            } else {
                free(substr);
            }
        }
    }

    return result[0] ? result : " ";
}