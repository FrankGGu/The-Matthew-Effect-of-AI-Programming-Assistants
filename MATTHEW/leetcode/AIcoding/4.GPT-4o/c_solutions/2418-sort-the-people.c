#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

char **sortPeople(char **names, int namesSize, int *heights, int heightsSize, int *returnSize) {
    int *indices = (int *)malloc(namesSize * sizeof(int));
    for (int i = 0; i < namesSize; i++) {
        indices[i] = i;
    }

    qsort(indices, namesSize, sizeof(int), compare);

    char **sortedNames = (char **)malloc(namesSize * sizeof(char *));
    for (int i = 0; i < namesSize; i++) {
        sortedNames[i] = names[indices[i]];
    }

    free(indices);
    *returnSize = namesSize;
    return sortedNames;
}