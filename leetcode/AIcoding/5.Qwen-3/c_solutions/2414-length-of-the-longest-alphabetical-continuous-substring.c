#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestAlphabeticalSubstring(char *s) {
    int max_len = 1;
    int current_len = 1;
    for (int i = 1; i < strlen(s); i++) {
        if (s[i] > s[i - 1]) {
            current_len++;
            if (current_len > max_len) {
                max_len = current_len;
            }
        } else {
            current_len = 1;
        }
    }
    return max_len;
}