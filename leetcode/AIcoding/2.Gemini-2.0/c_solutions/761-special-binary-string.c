#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* makeLargestSpecial(char* s) {
    int count = 0, i = 0;
    char** subs = (char**)malloc(strlen(s) * sizeof(char*));
    int subsSize = 0;

    for (int j = 0; s[j] != '\0'; j++) {
        if (s[j] == '1') {
            count++;
        } else {
            count--;
        }

        if (count == 0) {
            char* sub = (char*)malloc((j - i + 2) * sizeof(char));
            strncpy(sub + 1, s + i + 1, j - i - 1);
            sub[0] = '1';
            sub[j - i] = '0';
            sub[j - i + 1] = '\0';

            sub = makeLargestSpecial(sub);
            subs[subsSize++] = sub;
            i = j + 1;
        }
    }

    qsort(subs, subsSize, sizeof(char*), (int (*)(const void *, const void *))strcmp);

    char* result = (char*)malloc((strlen(s) + 1) * sizeof(char));
    result[0] = '\0';
    for (int j = subsSize - 1; j >= 0; j--) {
        strcat(result, subs[j]);
        free(subs[j]);
    }
    free(subs);

    return result;
}