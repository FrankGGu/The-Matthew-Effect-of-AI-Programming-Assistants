#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

bool isNumber(char *s) {
    int i = 0, n = strlen(s);
    while (i < n && s[i] == ' ') i++;
    if (i == n) return false;
    if (s[i] == '+' || s[i] == '-') i++;
    bool numeric = false;
    while (i < n && isdigit(s[i])) {
        numeric = true;
        i++;
    }
    if (i < n && s[i] == '.') {
        i++;
        while (i < n && isdigit(s[i])) {
            numeric = true;
            i++;
        }
    }
    if (numeric && i < n && (s[i] == 'e' || s[i] == 'E')) {
        i++;
        if (i < n && (s[i] == '+' || s[i] == '-')) i++;
        numeric = false;
        while (i < n && isdigit(s[i])) {
            numeric = true;
            i++;
        }
    }
    while (i < n && s[i] == ' ') i++;
    return numeric && i == n;
}