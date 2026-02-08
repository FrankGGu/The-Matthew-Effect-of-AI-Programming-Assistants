#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** letterCasePermutation(char * s, int* returnSize){
    int len = strlen(s);
    int queueSize = 1;
    for (int i = 0; i < len; i++) {
        if (isalpha(s[i])) {
            queueSize *= 2;
        }
    }

    char **result = (char **)malloc(queueSize * sizeof(char *));
    *returnSize = 0;

    char *initial = (char *)malloc((len + 1) * sizeof(char));
    strcpy(initial, s);
    result[(*returnSize)++] = initial;

    for (int i = 0; i < len; i++) {
        if (isalpha(s[i])) {
            int currentSize = *returnSize;
            for (int j = 0; j < currentSize; j++) {
                char *current = result[j];
                char *newStr = (char *)malloc((len + 1) * sizeof(char));
                strcpy(newStr, current);
                if (islower(newStr[i])) {
                    newStr[i] = toupper(newStr[i]);
                } else {
                    newStr[i] = tolower(newStr[i]);
                }
                result[(*returnSize)++] = newStr;
            }
        }
    }

    return result;
}