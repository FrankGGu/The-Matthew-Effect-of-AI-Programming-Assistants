#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shuffleString(char* s, int* indices, int sSize) {
    char* result = (char*)malloc((sSize + 1) * sizeof(char));
    for (int i = 0; i < sSize; i++) {
        result[indices[i]] = s[i];
    }
    result[sSize] = '\0';
    return result;
}