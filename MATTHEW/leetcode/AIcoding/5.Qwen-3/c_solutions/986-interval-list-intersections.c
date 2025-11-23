#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

int** intervalIntersection(int** A, int ASize, int* AColSizes, int** B, int BSize, int* BColSizes, int* returnSize, int** returnColumnSizes) {
    int i = 0, j = 0;
    int** result = (int**)malloc(sizeof(int*) * (ASize + BSize));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (ASize + BSize));
    *returnSize = 0;

    while (i < ASize && j < BSize) {
        int start = (A[i][0] > B[j][0]) ? A[i][0] : B[j][0];
        int end = (A[i][1] < B[j][1]) ? A[i][1] : B[j][1];

        if (start <= end) {
            result[*returnSize] = (int*)malloc(sizeof(int) * 2);
            result[*returnSize][0] = start;
            result[*returnSize][1] = end;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }

        if (A[i][1] < B[j][1]) {
            i++;
        } else {
            j++;
        }
    }

    return result;
}