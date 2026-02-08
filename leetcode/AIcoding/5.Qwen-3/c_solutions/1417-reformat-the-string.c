#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reformat(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i = 0, j = 0;
    int alphaCount = 0, digitCount = 0;

    for (int k = 0; k < len; k++) {
        if (isalpha(s[k])) alphaCount++;
        else digitCount++;
    }

    if (abs(alphaCount - digitCount) > 1) {
        return "";
    }

    int a = 0, d = 0;
    if (alphaCount > digitCount) {
        for (int k = 0; k < len; k++) {
            if (a < alphaCount) {
                result[k] = s[a];
                a++;
            } else {
                result[k] = s[d];
                d++;
            }
        }
    } else {
        for (int k = 0; k < len; k++) {
            if (d < digitCount) {
                result[k] = s[d];
                d++;
            } else {
                result[k] = s[a];
                a++;
            }
        }
    }

    result[len] = '\0';
    return result;
}