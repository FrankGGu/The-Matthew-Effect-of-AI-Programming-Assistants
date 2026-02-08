#include <stdbool.h>
#include <string.h>

char * greatestLetter(char * s){
    bool seenLower[26] = {false};
    bool seenUpper[26] = {false};

    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            seenLower[s[i] - 'a'] = true;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            seenUpper[s[i] - 'A'] = true;
        }
    }

    static char result[2];
    result[1] = '\0';

    for (int i = 25; i >= 0; i--) {
        if (seenLower[i] && seenUpper[i]) {
            result[0] = 'A' + i;
            return result;
        }
    }

    result[0] = '\0';
    return result;
}