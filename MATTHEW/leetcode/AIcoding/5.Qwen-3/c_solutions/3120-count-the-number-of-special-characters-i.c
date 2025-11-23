#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSpecialChars(char *s) {
    int count = 0;
    int seenLower[26] = {0};
    int seenUpper[26] = {0};

    for (int i = 0; s[i]; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            seenLower[s[i] - 'a'] = 1;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            seenUpper[s[i] - 'A'] = 1;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (seenLower[i] && seenUpper[i]) {
            count++;
        }
    }

    return count;
}