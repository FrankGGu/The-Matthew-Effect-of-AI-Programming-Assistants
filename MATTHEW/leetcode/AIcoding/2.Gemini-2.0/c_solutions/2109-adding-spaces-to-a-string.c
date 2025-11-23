#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * addSpaces(char * s, int* spaces, int spacesSize){
    int sLen = strlen(s);
    int newLen = sLen + spacesSize;
    char *result = (char *)malloc(sizeof(char) * (newLen + 1));
    int sIndex = 0;
    int spacesIndex = 0;
    int resultIndex = 0;

    while (sIndex < sLen) {
        if (spacesIndex < spacesSize && sIndex == spaces[spacesIndex]) {
            result[resultIndex++] = ' ';
            spacesIndex++;
        }
        result[resultIndex++] = s[sIndex++];
    }
    result[resultIndex] = '\0';
    return result;
}