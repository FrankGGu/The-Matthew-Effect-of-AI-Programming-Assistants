#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lexSmallestString(char* s, int a, int b) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < len; i++) {
        char* current = (char*)malloc((len + 1) * sizeof(char));
        strcpy(current, s);

        for (int j = 0; j < len; j++) {
            if ((j - i) % 2 == 0) {
                current[j] = 'a' + (current[j] - 'a' + a) % 26;
            }
        }

        for (int k = 0; k < len; k++) {
            if ((k - i) % 2 == 0) {
                current[k] = 'a' + (current[k] - 'a' + a) % 26;
            }
        }

        if (strcmp(current, result) < 0) {
            strcpy(result, current);
        }

        free(current);
    }

    return result;
}