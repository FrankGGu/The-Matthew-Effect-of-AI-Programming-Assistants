#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isNumber(char *s) {
    int len = strlen(s);
    int i = 0;
    bool hasDigit = false;
    bool hasE = false;
    bool hasDot = false;

    while (i < len && s[i] == ' ') {
        i++;
    }

    if (i < len && (s[i] == '+' || s[i] == '-')) {
        i++;
    }

    while (i < len && (s[i] >= '0' && s[i] <= '9')) {
        hasDigit = true;
        i++;
    }

    if (i < len && s[i] == '.') {
        hasDot = true;
        i++;
        while (i < len && (s[i] >= '0' && s[i] <= '9')) {
            hasDigit = true;
            i++;
        }
    }

    if (i < len && (s[i] == 'e' || s[i] == 'E')) {
        if (!hasDigit) {
            return false;
        }
        hasE = true;
        i++;
        hasDigit = false;

        if (i < len && (s[i] == '+' || s[i] == '-')) {
            i++;
        }

        while (i < len && (s[i] >= '0' && s[i] <= '9')) {
            hasDigit = true;
            i++;
        }
        if (!hasDigit) {
            return false;
        }
    }

    while (i < len && s[i] == ' ') {
        i++;
    }

    return i == len;
}