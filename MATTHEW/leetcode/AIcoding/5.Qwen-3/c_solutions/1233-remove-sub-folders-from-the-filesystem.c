#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **removeSubfolders(char **folderList, int folderListSize, int *returnSize) {
    char **result = (char **)malloc(folderListSize * sizeof(char *));
    int count = 0;
    qsort(folderList, folderListSize, sizeof(char *), (int (*)(const void *, const void *))strcmp);

    for (int i = 0; i < folderListSize; i++) {
        if (i == 0 || strncmp(folderList[i], folderList[i - 1], strlen(folderList[i - 1])) != 0) {
            result[count++] = strdup(folderList[i]);
        }
    }

    *returnSize = count;
    return result;
}