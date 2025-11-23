#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    double diagonal_a = sqrt(pow((double)((int*)a)[0], 2) + pow((double)((int*)a)[1], 2));
    double diagonal_b = sqrt(pow((double)((int*)b)[0], 2) + pow((double)((int*)b)[1], 2));

    if (diagonal_a < diagonal_b) return -1;
    if (diagonal_a > diagonal_b) return 1;

    long long area_a = (long long)((int*)a)[0] * (long long)((int*)a)[1];
    long long area_b = (long long)((int*)b)[0] * (long long)((int*)b)[1];

    if (area_a < area_b) return -1;
    if (area_a > area_b) return 1;
    return 0;
}

int maxAreaOfLongestDiagonal(int** dimensions, int dimensionsSize, int* dimensionsColSize){
    qsort(dimensions, dimensionsSize, sizeof(dimensions[0]), compare);
    return dimensions[dimensionsSize - 1][0] * dimensions[dimensionsSize - 1][1];
}