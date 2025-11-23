#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b, void *arg) {
    int k = *(int *)arg;
    int *row1 = *(int **)a;
    int *row2 = *(int **)b;
    return row2[k] - row1[k];
}

int** sortTheStudents(int** score, int scoreSize, int* scoreColSize, int k, int* returnSize, int** returnColumnSizes){
    qsort_r(score, scoreSize, sizeof(int*), compare, &k);

    *returnSize = scoreSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * scoreSize);
    for(int i = 0; i < scoreSize; i++){
        (*returnColumnSizes)[i] = *scoreColSize;
    }

    return score;
}