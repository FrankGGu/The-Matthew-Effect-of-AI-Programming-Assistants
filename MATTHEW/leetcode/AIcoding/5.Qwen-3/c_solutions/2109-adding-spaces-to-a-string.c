#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* addSpaces(char* s, int* spaces, int spacesSize) {
    int totalLength = strlen(s);
    for (int i = 0; i < spacesSize; i++) {
        totalLength += 1;
    }
    char* result = (char*)malloc((totalLength + 1) * sizeof(char));
    int resultIndex = 0;
    int spaceIndex = 0;
    for (int i = 0; i < strlen(s); i++) {
        if (spaceIndex < spacesSize && i == spaces[spaceIndex]) {
            result[resultIndex++] = ' ';
            spaceIndex++;
        }
        result[resultIndex++] = s[i];
    }
    result[resultIndex] = '\0';
    return result;
}