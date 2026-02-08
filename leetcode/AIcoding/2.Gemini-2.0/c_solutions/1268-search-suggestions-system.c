#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char ***suggestedProducts(char **products, int productsSize, char *searchWord, int *returnSize, int **returnColumnSizes) {
    qsort(products, productsSize, sizeof(char *), compare);

    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(strlen(searchWord) * sizeof(int));
    char ***result = (char ***)malloc(strlen(searchWord) * sizeof(char **));

    int left = 0, right = productsSize - 1;
    for (int i = 0; searchWord[i] != '\0'; i++) {
        char prefix[i + 2];
        strncpy(prefix, searchWord, i + 1);
        prefix[i + 1] = '\0';

        while (left <= right && strncmp(products[left], prefix, i + 1) != 0) {
            left++;
        }
        while (left <= right && strncmp(products[right], prefix, i + 1) != 0) {
            right--;
        }

        result[*returnSize] = (char **)malloc(3 * sizeof(char *));
        (*returnColumnSizes)[*returnSize] = 0;
        int count = 0;
        for (int j = left; j <= right && count < 3; j++) {
            if (strncmp(products[j], prefix, i + 1) == 0) {
                result[*returnSize][count] = products[j];
                count++;
                (*returnColumnSizes)[*returnSize]++;
            }
        }

        *returnSize += 1;
    }

    return result;
}