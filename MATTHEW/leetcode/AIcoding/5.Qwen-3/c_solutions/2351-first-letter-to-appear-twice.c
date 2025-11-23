#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* repeatedCharacter(char* s) {
    int seen[26] = {0};
    for (int i = 0; s[i]; i++) {
        int index = s[i] - 'a';
        if (seen[index]) {
            char* result = (char*)malloc(2 * sizeof(char));
            result[0] = s[i];
            result[1] = '\0';
            return result;
        }
        seen[index] = 1;
    }
    return NULL;
}