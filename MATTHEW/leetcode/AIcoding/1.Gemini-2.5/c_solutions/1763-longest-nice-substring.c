#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

bool isNice(char* s, int start, int end) {
    bool lower[26] = {false};
    bool upper[26] = {false};

    for (int k = start; k <= end; k++) {
        if (islower(s[k])) {
            lower[s[k] - 'a'] = true;
        } else {
            upper[s[k] - 'A'] = true;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (lower[i] != upper[i]) {
            return false;
        }
    }
    return true;
}

char* longestNiceSubstring(char* s) {
    int n = strlen(s);
    int maxLen = 0;
    int startIndex = -1;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int currentLen = j - i + 1;
            if (isNice(s, i, j)) {
                if (currentLen > maxLen) {
                    maxLen = currentLen;
                    startIndex = i;
                }
            }
        }
    }

    if (startIndex == -1) {
        char* res = (char*)malloc(sizeof(char));
        res[0] = '\0';
        return res;
    } else {
        char* res = (char*)malloc((maxLen + 1) * sizeof(char));
        strncpy(res, s + startIndex, maxLen);
        res[maxLen] = '\0';
        return res;
    }
}