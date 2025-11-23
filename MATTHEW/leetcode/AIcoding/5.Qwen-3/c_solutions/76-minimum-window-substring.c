#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minWindow(char* s, char* t) {
    if (s == NULL || t == NULL || strlen(s) < strlen(t)) return "";

    int required = 0;
    int count[256] = {0};
    int window[256] = {0};

    for (int i = 0; t[i]; i++) {
        if (count[t[i]]++ == 0) required++;
    }

    int formed = 0;
    int left = 0, right = 0;
    int minLen = INT_MAX;
    int resultStart = 0;

    while (right < strlen(s)) {
        char c = s[right];
        window[c]++;
        if (window[c] == count[c]) formed++;
        right++;

        while (formed == required) {
            if (right - left < minLen) {
                minLen = right - left;
                resultStart = left;
            }

            c = s[left];
            window[c]--;
            if (window[c] < count[c]) formed--;
            left++;
        }
    }

    if (minLen == INT_MAX) return "";
    char* result = (char*)malloc(minLen + 1);
    strncpy(result, s + resultStart, minLen);
    result[minLen] = '\0';
    return result;
}