#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findStudents(int** score, int scoreSize, int* scoreColSize, int* returnSize) {
    int* result = (int*)malloc(scoreSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < scoreSize; i++) {
        if (score[i][1] - score[i][0] > 0) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }

    return result;
}