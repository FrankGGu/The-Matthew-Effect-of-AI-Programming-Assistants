#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char ** removeSubfolders(char ** folder, int folderSize, int* returnSize){
    qsort(folder, folderSize, sizeof(char*), cmp);

    char **result = (char **)malloc(folderSize * sizeof(char*));
    int count = 0;
    result[count++] = strdup(folder[0]);

    for (int i = 1; i < folderSize; i++) {
        int len = strlen(result[count - 1]);
        int folder_len = strlen(folder[i]);

        if (folder_len > len && strncmp(result[count - 1], folder[i], len) == 0 && folder[i][len] == '/') {
            continue;
        } else {
            result[count++] = strdup(folder[i]);
        }
    }

    *returnSize = count;
    return result;
}