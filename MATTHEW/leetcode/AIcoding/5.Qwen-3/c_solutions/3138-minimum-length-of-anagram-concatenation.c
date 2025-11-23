#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAnagramConcatenation(char *s) {
    int freq[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int required = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            required++;
        }
    }

    return (required == 0) ? 0 : (required / 2 + 1);
}