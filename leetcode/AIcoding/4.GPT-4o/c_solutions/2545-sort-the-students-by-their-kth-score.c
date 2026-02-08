#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *studentA = *(int **)a;
    int *studentB = *(int **)b;
    return studentA[1] - studentB[1];
}

int** sortTheStudents(int** score, int scoreSize, int k, int* returnSize) {
    *returnSize = scoreSize;
    qsort(score, scoreSize, sizeof(int*), compare);
    return score;
}