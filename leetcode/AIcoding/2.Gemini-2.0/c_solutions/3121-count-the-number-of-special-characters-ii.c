#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialCharacters(char *s) {
    int count = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (!((s[i] >= 'a' && s[i] <= 'z') || (s[i] >= 'A' && s[i] <= 'Z') || (s[i] >= '0' && s[i] <= '9'))) {
            count++;
        }
    }
    return count;
}