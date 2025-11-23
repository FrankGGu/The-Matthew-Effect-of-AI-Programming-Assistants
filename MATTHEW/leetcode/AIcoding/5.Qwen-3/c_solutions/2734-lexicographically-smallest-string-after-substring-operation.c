#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lexSmallestString(char* s, int a, int b) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < len; i++) {
        if ((i + b) % len == 0) {
            for (int j = 0; j < len; j++) {
                if (j % 2 == 0) {
                    result[j] = 'a' + (result[j] - 'a' + a) % 26;
                }
            }
            break;
        }
    }

    return result;
}