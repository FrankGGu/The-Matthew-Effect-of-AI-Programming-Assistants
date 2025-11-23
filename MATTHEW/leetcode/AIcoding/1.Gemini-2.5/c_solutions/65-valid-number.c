#include <stdbool.h>
#include <ctype.h>

bool isNumber(char *s) {
    int i = 0;
    bool digitsBeforeDot = false;
    bool digitsAfterDot = false;
    bool seenDot = false;
    bool seenE = false;

    while (s[i] != '\0' && isspace(s[i])) {
        i++;
    }

    if (s[i] == '+' || s[i] == '-') {
        i++;
    }

    while (s[i] != '\0' && isdigit(s[i])) {
        digitsBeforeDot = true;
        i++;
    }

    if (s[i] == '.') {
        seenDot = true;
        i++;
        while (s[i] != '\0' && isdigit(s[i])) {
            digitsAfterDot = true;
            i++;
        }
    }

    if (!digitsBeforeDot && !digitsAfterDot) {
        return false;
    }

    if (s[i] == 'e' || s[i] == 'E') {
        if (seenDot && !digitsAfterDot) {
            return false;
        }

        seenE = true;
        i++;
        bool digitsAfterE = false;

        if (s[i] == '+' || s[i] == '-') {
            i++;
        }
        while (s[i] != '\0' && isdigit(s[i])) {
            digitsAfterE = true;
            i++;
        }
        if (!digitsAfterE) {
            return false;
        }
    }

    while (s[i] != '\0' && isspace(s[i])) {
        i++;
    }

    return s[i] == '\0';
}