#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLengthBetweenEqualCharacters(char* s) {
    int maxLen = -1;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        for (int j = i + 1; j < len; j++) {
            if (s[i] == s[j]) {
                int currentLen = j - i - 1;
                if (currentLen > maxLen) {
                    maxLen = currentLen;
                }
            }
        }
    }
    return maxLen;
}