/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int compare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char*** suggestedProducts(char** products, int productsSize, char* searchWord, int* returnSize, int** returnColumnSizes) {
    qsort(products, productsSize, sizeof(char*), compare);

    int len = strlen(searchWord);
    char*** res = (char***)malloc(len * sizeof(char**));
    *returnColumnSizes = (int*)malloc(len * sizeof(int));
    *returnSize = len;

    for (int i = 0; i < len; i++) {
        res[i] = (char**)malloc(3 * sizeof(char*));
        int count = 0;
        char prefix[i + 2];
        strncpy(prefix, searchWord, i + 1);
        prefix[i + 1] = '\0';

        for (int j = 0; j < productsSize && count < 3; j++) {
            if (strncmp(products[j], prefix, i + 1) == 0) {
                res[i][count] = products[j];
                count++;
            }
        }

        (*returnColumnSizes)[i] = count;
        for (int k = count; k < 3; k++) {
            res[i][k] = NULL;
        }
    }

    return res;
}