#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* truncateSentence(char* s, int k) {
    int len = strlen(s);
    char* result = (char*)malloc((k + 1) * sizeof(char));
    int i = 0;
    for (i = 0; i < k && i < len; i++) {
        result[i] = s[i];
    }
    result[i] = '\0';
    return result;
}