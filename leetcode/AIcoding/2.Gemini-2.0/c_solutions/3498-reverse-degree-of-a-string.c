#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *reverseDegree(char *s, int degree) {
    int len = strlen(s);
    if (len == 0 || degree <= 0) {
        return s;
    }

    degree %= len;
    if (degree == 0) {
        return s;
    }

    char temp[len + 1];
    strcpy(temp, s);

    for (int i = 0; i < len; i++) {
        s[i] = temp[(i + len - degree) % len];
    }

    return s;
}