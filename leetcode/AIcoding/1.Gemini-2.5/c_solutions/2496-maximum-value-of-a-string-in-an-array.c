#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int maximumValue(char **strs, int strsSize) {
    int maxValue = 0;

    for (int i = 0; i < strsSize; i++) {
        char *s = strs[i];
        int currentValue;
        int onlyDigits = 1;
        int len = 0;

        for (int j = 0; s[j] != '\0'; j++) {
            len++;
            if (!isdigit(s[j])) {
                onlyDigits = 0;
            }
        }

        if (onlyDigits) {
            currentValue = atoi(s);
        } else {
            currentValue = len;
        }

        if (currentValue > maxValue) {
            maxValue = currentValue;
        }
    }

    return maxValue;
}