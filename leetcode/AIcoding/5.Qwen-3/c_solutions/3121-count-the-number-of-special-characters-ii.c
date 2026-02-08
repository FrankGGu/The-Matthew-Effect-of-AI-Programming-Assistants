#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSpecialChars(char *s) {
    int count[26] = {0};
    int result = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            count[s[i] - 'a']++;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            int hasUpper = 0;
            for (int j = 0; s[j]; j++) {
                if (s[j] == (i + 'A')) {
                    hasUpper = 1;
                    break;
                }
            }
            if (hasUpper) {
                result++;
            }
        }
    }
    return result;
}