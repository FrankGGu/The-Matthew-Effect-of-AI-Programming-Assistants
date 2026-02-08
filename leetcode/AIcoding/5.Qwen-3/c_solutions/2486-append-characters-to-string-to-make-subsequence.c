#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int appendCharacters(char *s, char *t) {
    int i = 0, j = 0;
    int len_s = strlen(s);
    int len_t = strlen(t);

    while (i < len_s && j < len_t) {
        if (s[i] == t[j]) {
            j++;
        }
        i++;
    }

    return len_t - j;
}