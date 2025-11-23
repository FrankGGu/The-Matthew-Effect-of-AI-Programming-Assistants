#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthOfLongestSubstring(char * s){
    int n = strlen(s);
    int maxLength = 0;
    int start = 0;
    int end = 0;
    int charIndex[256];
    for (int i = 0; i < 256; i++) {
        charIndex[i] = -1;
    }

    while (end < n) {
        if (charIndex[s[end]] != -1 && charIndex[s[end]] >= start) {
            start = charIndex[s[end]] + 1;
        }
        charIndex[s[end]] = end;
        maxLength = (end - start + 1) > maxLength ? (end - start + 1) : maxLength;
        end++;
    }

    return maxLength;
}