#include <string.h>
#include <stdlib.h>

static int expandAroundCenter(char* s, int left, int right, int n) {
    while (left >= 0 && right < n && s[left] == s[right]) {
        left--;
        right++;
    }
    return right - left - 1;
}

char* longestPalindrome(char* s) {
    int n = strlen(s);
    if (n < 1) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    int start = 0;
    int maxLength = 1;

    for (int i = 0; i < n; i++) {
        int len1 = expandAroundCenter(s, i, i, n);
        int len2 = expandAroundCenter(s, i, i + 1, n);

        int currentMaxLen = (len1 > len2) ? len1 : len2;

        if (currentMaxLen > maxLength) {
            maxLength = currentMaxLen;
            start = i - (maxLength - 1) / 2;
        }
    }

    char* result = (char*)malloc(maxLength + 1);
    strncpy(result, s + start, maxLength);
    result[maxLength] = '\0';

    return result;
}