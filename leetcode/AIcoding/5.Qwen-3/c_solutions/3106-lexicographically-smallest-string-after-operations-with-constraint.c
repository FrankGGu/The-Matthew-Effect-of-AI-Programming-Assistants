#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lexSmallestString(char* s, int k) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (j - i <= k) {
                char temp = result[i];
                result[i] = result[j];
                result[j] = temp;
                if (strcmp(result, s) < 0) {
                    strcpy(s, result);
                }
                temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    return s;
}