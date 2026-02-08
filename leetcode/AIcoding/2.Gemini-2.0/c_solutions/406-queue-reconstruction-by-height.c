#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *pa = (int *)a;
    int *pb = (int *)b;
    if (pa[0] != pb[0]) {
        return pb[0] - pa[0];
    } else {
        return pa[1] - pb[1];
    }
}

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int* returnSize, int** returnColumnSizes) {
    qsort(people, peopleSize, sizeof(int*), cmp);

    int** result = (int**)malloc(peopleSize * sizeof(int*));
    for (int i = 0; i < peopleSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
    }

    *returnColumnSizes = (int*)malloc(peopleSize * sizeof(int));
    for (int i = 0; i < peopleSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    *returnSize = 0;
    int** temp = (int**)malloc(peopleSize * sizeof(int*));
    for (int i = 0; i < peopleSize; i++) {
        temp[i] = NULL;
    }

    for (int i = 0; i < peopleSize; i++) {
        int count = 0;
        int j = 0;
        for (; j < peopleSize; j++) {
            if (temp[j] == NULL) {
                if (count == people[i][1]) {
                    temp[j] = people[i];
                    break;
                }
                count++;
            }
        }
    }

    for (int i = 0; i < peopleSize; i++) {
        result[i][0] = temp[i][0];
        result[i][1] = temp[i][1];
    }

    free(temp);

    *returnSize = peopleSize;
    return result;
}