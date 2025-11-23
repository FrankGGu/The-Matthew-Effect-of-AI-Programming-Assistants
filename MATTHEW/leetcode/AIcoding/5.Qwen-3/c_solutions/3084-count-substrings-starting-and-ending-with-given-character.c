#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char* s, char c) {
    int count = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == c) {
            count++;
        }
    }
    return count * (count + 1) / 2;
}