#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char **name1 = (char **)a;
    char **name2 = (char **)b;
    return strcmp(*name1, *name2);
}

char** sortPeople(char** names, int namesSize, int* heights, int heightsSize, int* returnSize) {
    char **result = (char **)malloc(namesSize * sizeof(char *));
    for (int i = 0; i < namesSize; i++) {
        result[i] = (char *)malloc((strlen(names[i]) + 1) * sizeof(char));
        strcpy(result[i], names[i]);
    }

    for (int i = 0; i < namesSize - 1; i++) {
        for (int j = 0; j < namesSize - i - 1; j++) {
            if (heights[j] < heights[j + 1]) {
                char *temp = result[j];
                result[j] = result[j + 1];
                result[j + 1] = temp;

                int h = heights[j];
                heights[j] = heights[j + 1];
                heights[j + 1] = h;
            }
        }
    }

    *returnSize = namesSize;
    return result;
}