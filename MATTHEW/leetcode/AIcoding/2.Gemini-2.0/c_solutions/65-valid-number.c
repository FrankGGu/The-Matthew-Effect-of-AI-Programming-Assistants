#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isNumber(char *s) {
    bool seenDigit = false;
    bool seenExponent = false;
    bool seenDecimal = false;

    for (int i = 0; s[i] != '\0'; i++) {
        if (isdigit(s[i])) {
            seenDigit = true;
        } else if (s[i] == '.') {
            if (seenDecimal || seenExponent) {
                return false;
            }
            seenDecimal = true;
        } else if (s[i] == 'e' || s[i] == 'E') {
            if (seenExponent || !seenDigit) {
                return false;
            }
            seenExponent = true;
            seenDigit = false;
        } else if (s[i] == '+' || s[i] == '-') {
            if (i > 0 && s[i - 1] != 'e' && s[i - 1] != 'E') {
                return false;
            }
        } else {
            return false;
        }
    }

    return seenDigit;
}