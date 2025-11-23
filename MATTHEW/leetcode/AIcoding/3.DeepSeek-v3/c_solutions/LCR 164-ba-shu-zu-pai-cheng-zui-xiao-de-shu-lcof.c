#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char str1[25], str2[25];
    sprintf(str1, "%s%s", *(char**)a, *(char**)b);
    sprintf(str2, "%s%s", *(char**)b, *(char**)a);
    return strcmp(str1, str2);
}

char* crackPassword(int* password, int passwordSize) {
    char **strs = (char**)malloc(passwordSize * sizeof(char*));
    for (int i = 0; i < passwordSize; i++) {
        strs[i] = (char*)malloc(12 * sizeof(char));
        sprintf(strs[i], "%d", password[i]);
    }

    qsort(strs, passwordSize, sizeof(char*), compare);

    int totalLen = 0;
    for (int i = 0; i < passwordSize; i++) {
        totalLen += strlen(strs[i]);
    }

    char *result = (char*)malloc((totalLen + 1) * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < passwordSize; i++) {
        strcat(result, strs[i]);
        free(strs[i]);
    }
    free(strs);

    return result;
}