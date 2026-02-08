#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findSubstringInWrapup(char *s) {
    int len = strlen(s);
    int count[26] = {0};
    int max_len = 0;

    for (int i = 0; i < len; i++) {
        if (i > 0 && (s[i] - s[i-1] == 1 || s[i-1] - s[i] == 25)) {
            max_len++;
        } else {
            max_len = 1;
        }

        int index = s[i] - 'a';
        if (max_len > count[index]) {
            count[index] = max_len;
        }
    }

    int result = 0;
    for (int i = 0; i < 26; i++) {
        result += count[i];
    }

    return result;
}