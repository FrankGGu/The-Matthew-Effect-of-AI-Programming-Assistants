#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* smallestSubstring(char* s) {
    int n = strlen(s);
    int left = 0, right = 0;
    int minLen = n + 1;
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int count[256] = {0};
    int unique = 0;

    while (right < n) {
        if (count[s[right]]++ == 0) {
            unique++;
        }

        while (unique == 1) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                strncpy(result, s + left, minLen);
                result[minLen] = '\0';
            }

            if (--count[s[left]] == 0) {
                unique--;
            }
            left++;
        }

        right++;
    }

    return result;
}