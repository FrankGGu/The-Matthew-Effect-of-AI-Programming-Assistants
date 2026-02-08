#include <stdlib.h>
#include <string.h>

char* makeFancyString(char* s) {
    int n = strlen(s);

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int j = 0; 

    for (int i = 0; i < n; i++) {
        if (j >= 2 && s[i] == result[j-1] && s[i] == result[j-2]) {
            continue;
        } else {
            result[j] = s[i];
            j++;
        }
    }
    result[j] = '\0';

    return result;
}