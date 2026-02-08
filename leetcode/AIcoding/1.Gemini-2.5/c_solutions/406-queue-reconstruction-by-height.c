#include <stdlib.h>

int compare(const void *a, const void *b) {
    const int *personA = *(const int **)a;
    const int *personB = *(const int **)b;

    if (personA[0] != personB[0]) {
        return personB[0] - personA[0];
    }
    return personA[1] - personB[1];
}

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int** returnColumnSizes, int* returnSize) {
    qsort(people, peopleSize, sizeof(int*), compare);

    int** result = (int**)malloc(peopleSize * sizeof(int*));

    *returnSize = peopleSize;
    *returnColumnSizes = (int*)malloc(peopleSize * sizeof(int));
    for (int i = 0; i < peopleSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    int current_queue_size = 0;
    for (int i = 0; i < peopleSize; i++) {
        int k = people[i][1];

        for (int j = current_queue_size; j > k; j--) {
            result[j] = result[j-1];
        }

        result[k] = people[i];

        current_queue_size++;
    }

    return result;
}