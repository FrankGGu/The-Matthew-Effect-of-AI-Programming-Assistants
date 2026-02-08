#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int appendCharacters(char * s, char * t){
    int sLen = 0, tLen = 0;
    while (s[sLen] != '\0') sLen++;
    while (t[tLen] != '\0') tLen++;

    int i = 0, j = 0;
    while (i < sLen && j < tLen) {
        if (s[i] == t[j]) {
            j++;
        }
        i++;
    }

    return tLen - j;
}