#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *minWindow(char *s, char *t) {
    int sLen = strlen(s);
    int tLen = strlen(t);

    if (sLen == 0 || tLen == 0) {
        return "";
    }

    int need[256] = {0};
    int window[256] = {0};

    for (int i = 0; i < tLen; i++) {
        need[t[i]]++;
    }

    int left = 0;
    int right = 0;
    int valid = 0;
    int start = 0;
    int len = sLen + 1;

    while (right < sLen) {
        char c = s[right];
        right++;

        if (need[c] > 0) {
            window[c]++;
            if (window[c] == need[c]) {
                valid++;
            }
        }

        while (valid == tLen) {
            if (right - left < len) {
                start = left;
                len = right - left;
            }

            char d = s[left];
            left++;

            if (need[d] > 0) {
                if (window[d] == need[d]) {
                    valid--;
                }
                window[d]--;
            }
        }
    }

    if (len == sLen + 1) {
        return "";
    }

    char *result = (char *)malloc(len + 1);
    strncpy(result, s + start, len);
    result[len] = '\0';
    return result;
}