#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* customSortString(char* X, char* Y) {
    int count[26] = {0};
    for (int i = 0; Y[i]; i++) {
        count[Y[i] - 'a']++;
    }

    char* result = (char*)malloc((strlen(Y) + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; X[i]; i++) {
        while (count[X[i] - 'a']-- > 0) {
            result[index++] = X[i];
        }
    }

    for (int i = 0; i < 26; i++) {
        while (count[i]-- > 0) {
            result[index++] = i + 'a';
        }
    }

    result[index] = '\0';
    return result;
}