#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char greatestLetter(char * s){
    bool upper[26] = {false};
    bool lower[26] = {false};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            lower[s[i] - 'a'] = true;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            upper[s[i] - 'A'] = true;
        }
    }

    for (int i = 25; i >= 0; i--) {
        if (upper[i] && lower[i]) {
            char result[2];
            result[0] = 'A' + i;
            result[1] = '\0';
            return result[0];
        }
    }

    return '\0';
}