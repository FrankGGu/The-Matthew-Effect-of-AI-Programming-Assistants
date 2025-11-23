#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool fuzzyMatching(char* pattern, char* str) {
    int p = 0;
    int s = 0;
    while (p < strlen(pattern) && s < strlen(str)) {
        if (pattern[p] == str[s]) {
            p++;
        }
        s++;
    }
    return p == strlen(pattern);
}