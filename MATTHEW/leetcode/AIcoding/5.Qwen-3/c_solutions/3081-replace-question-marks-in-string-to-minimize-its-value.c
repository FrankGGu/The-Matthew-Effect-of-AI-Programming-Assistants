#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minimizeStringValue(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < len; i++) {
        if (result[i] == '?') {
            for (char c = 'a'; c <= 'z'; c++) {
                result[i] = c;
                int minDiff = 0;
                for (int j = 0; j < len; j++) {
                    if (result[j] != '?' && result[j] != s[j]) {
                        minDiff += abs(result[j] - s[j]);
                    }
                }
                int tempDiff = minDiff;
                for (int j = 0; j < len; j++) {
                    if (result[j] != '?' && result[j] != s[j]) {
                        tempDiff -= abs(result[j] - s[j]);
                    }
                }
                if (tempDiff < minDiff) {
                    break;
                }
            }
        }
    }

    return result;
}