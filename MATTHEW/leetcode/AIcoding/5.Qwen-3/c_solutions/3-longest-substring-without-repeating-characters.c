#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthOfLongestSubstring(char *s) {
    int max_len = 0;
    int start = 0;
    int char_index[256];
    for (int i = 0; i < 256; i++) {
        char_index[i] = -1;
    }
    for (int end = 0; end < strlen(s); end++) {
        if (char_index[s[end]] >= start) {
            start = char_index[s[end]] + 1;
        }
        char_index[s[end]] = end;
        if (end - start + 1 > max_len) {
            max_len = end - start + 1;
        }
    }
    return max_len;
}