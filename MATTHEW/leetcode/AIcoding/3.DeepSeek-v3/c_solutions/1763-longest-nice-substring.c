#include <string.h>
#include <stdbool.h>

bool isNice(char* s, int start, int end) {
    int upper[26] = {0};
    int lower[26] = {0};

    for (int i = start; i <= end; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            lower[s[i] - 'a'] = 1;
        } else {
            upper[s[i] - 'A'] = 1;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (upper[i] != lower[i]) {
            return false;
        }
    }
    return true;
}

char* longestNiceSubstring(char* s) {
    int n = strlen(s);
    int maxLen = 0;
    int start = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            if (isNice(s, i, j) && (j - i + 1) > maxLen) {
                maxLen = j - i + 1;
                start = i;
            }
        }
    }

    if (maxLen == 0) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    char* result = (char*)malloc(maxLen + 1);
    strncpy(result, s + start, maxLen);
    result[maxLen] = '\0';
    return result;
}