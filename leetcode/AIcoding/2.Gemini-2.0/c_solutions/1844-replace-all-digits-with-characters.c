#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char shift(char c, char x) {
    return c + (x - '0');
}

char *replaceDigits(char *s) {
    int n = strlen(s);
    for (int i = 1; i < n; i += 2) {
        s[i] = shift(s[i - 1], s[i]);
    }
    return s;
}