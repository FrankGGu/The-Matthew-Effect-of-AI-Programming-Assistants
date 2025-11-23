#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *studentA = *(int**)a;
    int *studentB = *(int**)b;
    return studentB[1] - studentA[1];
}

int** sortTheStudents(int** score, int scoreSize, int* scoreColSize, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = scoreSize;
    *returnColumnSizes = (int*)malloc(scoreSize * sizeof(int));
    for (int i = 0; i < scoreSize; i++) {
        (*returnColumnSizes)[i] = *scoreColSize;
    }

    qsort(score, scoreSize, sizeof(int*), compare);
    return score;
}