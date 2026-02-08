#include <stdlib.h>
#include <string.h>
#include <limits.h>

char* minWindow(char* s, char* t) {
    int sLen = strlen(s);
    int tLen = strlen(t);

    if (sLen == 0 || tLen == 0 || sLen < tLen) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    int tFreq[128] = {0};
    int windowFreq[128] = {0};

    for (int i = 0; i < tLen; i++) {
        tFreq[t[i]]++;
    }

    int required = 0;
    for (int i = 0; i < 128; i++) {
        if (tFreq[i] > 0) required++;
    }

    int left = 0, right = 0;
    int formed = 0;
    int minLen = INT_MAX;
    int minLeft = 0;

    while (right < sLen) {
        char c = s[right];
        windowFreq[c]++;

        if (tFreq[c] > 0 && windowFreq[c] == tFreq[c]) {
            formed++;
        }

        while (left <= right && formed == required) {
            c = s[left];

            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                minLeft = left;
            }

            windowFreq[c]--;
            if (tFreq[c] > 0 && windowFreq[c] < tFreq[c]) {
                formed--;
            }
            left++;
        }
        right++;
    }

    if (minLen == INT_MAX) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    char* result = (char*)malloc(minLen + 1);
    strncpy(result, s + minLeft, minLen);
    result[minLen] = '\0';
    return result;
}