#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSubstringPresent(char * s) {
    int len = strlen(s);
    char *rev = (char *)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        rev[i] = s[len - 1 - i];
    }
    rev[len] = '\0';

    for (int i = 0; i < len - 1; i++) {
        char sub[3] = {s[i], s[i + 1], '\0'};
        char *pos = strstr(rev, sub);
        if (pos != NULL) {
            free(rev);
            return true;
        }
    }

    free(rev);
    return false;
}