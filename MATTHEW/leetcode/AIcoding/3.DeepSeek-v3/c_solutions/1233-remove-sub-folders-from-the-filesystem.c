/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char** removeSubfolders(char** folder, int folderSize, int* returnSize) {
    qsort(folder, folderSize, sizeof(char*), cmp);

    char** result = (char**)malloc(folderSize * sizeof(char*));
    *returnSize = 0;

    result[(*returnSize)++] = folder[0];

    for (int i = 1; i < folderSize; i++) {
        char* last = result[*returnSize - 1];
        int len = strlen(last);

        if (strncmp(folder[i], last, len) != 0 || 
            (folder[i][len] != '/' && folder[i][len] != '\0')) {
            result[(*returnSize)++] = folder[i];
        }
    }

    return result;
}