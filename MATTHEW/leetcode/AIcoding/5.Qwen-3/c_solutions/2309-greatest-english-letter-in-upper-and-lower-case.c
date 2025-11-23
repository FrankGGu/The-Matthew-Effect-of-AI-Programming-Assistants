#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* greatestLetter(char* s) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            freq[s[i] - 'a']++;
        }
    }
    char* result = (char*)malloc(2 * sizeof(char));
    result[1] = '\0';
    for (int i = 25; i >= 0; i--) {
        if (freq[i] > 0) {
            result[0] = 'A' + i;
            return result;
        }
    }
    result[0] = '\0';
    return result;
}