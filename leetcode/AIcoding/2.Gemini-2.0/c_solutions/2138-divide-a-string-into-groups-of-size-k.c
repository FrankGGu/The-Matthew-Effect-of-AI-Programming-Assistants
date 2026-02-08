#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** divideString(char * s, int k, char fill, int* returnSize){
    int len = strlen(s);
    int numGroups = (len + k - 1) / k;
    *returnSize = numGroups;
    char **result = (char **)malloc(numGroups * sizeof(char *));
    for (int i = 0; i < numGroups; i++) {
        result[i] = (char *)malloc((k + 1) * sizeof(char));
        memset(result[i], 0, (k + 1) * sizeof(char));
    }

    int sIndex = 0;
    for (int i = 0; i < numGroups; i++) {
        for (int j = 0; j < k; j++) {
            if (sIndex < len) {
                result[i][j] = s[sIndex++];
            } else {
                result[i][j] = fill;
            }
        }
        result[i][k] = '\0';
    }

    return result;
}