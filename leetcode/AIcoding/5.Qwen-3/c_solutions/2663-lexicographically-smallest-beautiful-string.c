#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* splitString(char* s, int start, int end) {
    char* result = (char*)malloc((end - start + 1) * sizeof(char));
    strncpy(result, s + start, end - start);
    result[end - start] = '\0';
    return result;
}

char* lexSmallestBeautifulString(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (s[i] != s[j]) {
                char temp = s[i];
                s[i] = s[j];
                s[j] = temp;

                char* candidate = (char*)malloc((n + 1) * sizeof(char));
                strcpy(candidate, s);

                int valid = 1;
                for (int k = 0; k < n - 1; k++) {
                    if (candidate[k] == candidate[k + 1]) {
                        valid = 0;
                        break;
                    }
                }

                if (valid) {
                    if (strcmp(candidate, result) < 0) {
                        strcpy(result, candidate);
                    }
                }

                free(candidate);
                s[i] = temp;
                s[j] = s[i];
            }
        }
    }

    return result;
}