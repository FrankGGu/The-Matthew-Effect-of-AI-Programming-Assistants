#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* capitalizeTitle(char* title) {
    int len = strlen(title);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i = 0, j = 0;

    while (i < len) {
        int wordStart = i;
        while (i < len && title[i] != ' ') {
            i++;
        }
        int wordLen = i - wordStart;
        for (int k = 0; k < wordLen; k++) {
            if (k == 0) {
                result[j++] = toupper(title[wordStart]);
            } else if (k == wordLen - 1) {
                result[j++] = tolower(title[wordStart + k]);
            } else {
                result[j++] = tolower(title[wordStart + k]);
            }
        }
        if (i < len) {
            result[j++] = ' ';
        }
        i++;
    }
    result[j] = '\0';
    return result;
}