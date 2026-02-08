#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** letterCasePermutation(char* s, int* returnSize) {
    int n = strlen(s);
    int count = 1;
    for (int i = 0; i < n; i++) {
        if (isalpha(s[i])) count *= 2;
    }
    *returnSize = count;
    char** result = (char**)malloc(count * sizeof(char*));
    for (int i = 0; i < count; i++) {
        result[i] = (char*)malloc((n + 1) * sizeof(char));
    }
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (isalpha(s[i])) {
            int prevCount = count / 2;
            for (int j = 0; j < prevCount; j++) {
                strcpy(result[index + j], result[j]);
                result[index + j][i] = tolower(s[i]);
            }
            for (int j = 0; j < prevCount; j++) {
                strcpy(result[index + prevCount + j], result[j]);
                result[index + prevCount + j][i] = toupper(s[i]);
            }
            index += prevCount;
            count /= 2;
        } else {
            for (int j = 0; j < count; j++) {
                result[j][i] = s[i];
            }
        }
    }
    for (int i = 0; i < count; i++) {
        result[i][n] = '\0';
    }
    return result;
}