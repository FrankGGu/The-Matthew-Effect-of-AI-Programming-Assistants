#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* licenseKeyFormatting(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    int groupCount = 0;

    for (int i = len - 1; i >= 0; i--) {
        if (s[i] != '-') {
            if (islower(s[i])) {
                result[index++] = toupper(s[i]);
            } else {
                result[index++] = s[i];
            }
            groupCount++;
            if (groupCount % 4 == 0) {
                result[index++] = '-';
            }
        }
    }

    if (index > 0 && result[index - 1] == '-') {
        result[index - 1] = '\0';
    } else {
        result[index] = '\0';
    }

    return result;
}