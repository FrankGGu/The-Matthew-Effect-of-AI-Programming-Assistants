#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lexSmallestString(char* s, int n) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < n - 1; i++) {
        if (s[i] > s[i + 1]) {
            char temp = s[i];
            s[i] = s[i + 1];
            s[i + 1] = temp;
            break;
        }
    }

    return result;
}