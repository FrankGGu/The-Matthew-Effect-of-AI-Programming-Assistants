#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestString(int n) {
    char *str = (char *)malloc((n + 1) * sizeof(char));
    if (str == NULL) {
        return NULL;
    }
    memset(str, 'a', n);
    str[n] = '\0';

    int remaining = n;
    while (remaining > 26) {
        str[n - remaining] = 'z';
        remaining -= 26;
    }

    if (remaining > 0) {
        str[n - remaining] = 'a' + remaining - 1;
    }

    return str;
}