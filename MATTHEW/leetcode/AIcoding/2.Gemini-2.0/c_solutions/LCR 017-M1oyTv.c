#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *minWindow(char *s, char *t) {
    int sLen = strlen(s);
    int tLen = strlen(t);

    if (sLen == 0 || tLen == 0 || sLen < tLen) {
        return "";
    }

    int tFreq[128] = {0};
    int windowFreq[128] = {0};

    for (int i = 0; i < tLen; i++) {
        tFreq[t[i]]++;
    }

    int left = 0, right = 0;
    int minLen = sLen + 1;
    int start = 0;
    int matched = 0;

    while (right < sLen) {
        char c = s[right];
        if (tFreq[c] > 0) {
            windowFreq[c]++;
            if (windowFreq[c] <= tFreq[c]) {
                matched++;
            }
        }

        while (matched == tLen) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                start = left;
            }

            char leftChar = s[left];
            if (tFreq[leftChar] > 0) {
                windowFreq[leftChar]--;
                if (windowFreq[leftChar] < tFreq[leftChar]) {
                    matched--;
                }
            }
            left++;
        }
        right++;
    }

    if (minLen > sLen) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (minLen + 1));
    strncpy(result, s + start, minLen);
    result[minLen] = '\0';

    return result;
}