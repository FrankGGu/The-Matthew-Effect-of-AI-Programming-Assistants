#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* longestNiceSubstring(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    result[0] = '\0';

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int isNice = 1;
            for (int k = i; k < j; k++) {
                char c = s[k];
                int hasUpper = 0, hasLower = 0;
                for (int m = i; m < j; m++) {
                    if (s[m] == c - 32) hasUpper = 1;
                    if (s[m] == c + 32) hasLower = 1;
                }
                if (!hasUpper && !hasLower) {
                    isNice = 0;
                    break;
                }
            }
            if (isNice) {
                char* current = (char*)malloc(sizeof(char) * (j - i + 1));
                strncpy(current, s + i, j - i);
                current[j - i] = '\0';
                if (strlen(current) > strlen(result)) {
                    free(result);
                    result = current;
                } else {
                    free(current);
                }
            }
        }
    }
    return result;
}