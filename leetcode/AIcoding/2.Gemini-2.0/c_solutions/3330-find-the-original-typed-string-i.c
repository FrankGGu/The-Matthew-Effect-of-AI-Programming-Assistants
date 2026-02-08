#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * findOriginalString(char * s){
    int i = 0, j = 0;
    int sLen = strlen(s);
    char *result = (char*)malloc(sizeof(char) * (sLen / 2 + 1));
    int resultIndex = 0;

    while (i < sLen) {
        result[resultIndex++] = s[i];
        i++;
        j = i;
        while (j < sLen && s[j] != s[i-1]) {
            j++;
        }
        i = j + 1;
    }
    result[resultIndex] = '\0';
    return result;
}