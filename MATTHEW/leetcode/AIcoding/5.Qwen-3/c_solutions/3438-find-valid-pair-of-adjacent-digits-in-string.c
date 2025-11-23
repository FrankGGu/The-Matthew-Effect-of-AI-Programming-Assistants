#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findValidPair(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i + 1]) {
            char* result = (char*)malloc(3 * sizeof(char));
            result[0] = s[i];
            result[1] = s[i + 1];
            result[2] = '\0';
            return result;
        }
    }
    return NULL;
}