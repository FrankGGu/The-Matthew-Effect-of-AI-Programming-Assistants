#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestBeautifulString(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, "");

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                continue;
            }
            char* temp = (char*)malloc((n + 1) * sizeof(char));
            strcpy(temp, s);
            temp[i] = s[j];
            temp[j] = s[i];
            if (strlen(result) == 0 || strcmp(temp, result) < 0) {
                strcpy(result, temp);
            }
            free(temp);
        }
    }

    return result;
}