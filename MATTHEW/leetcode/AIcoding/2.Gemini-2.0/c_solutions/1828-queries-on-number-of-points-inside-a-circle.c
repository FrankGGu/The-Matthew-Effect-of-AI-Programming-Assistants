#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countPoints(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int *result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        int count = 0;
        for (int j = 0; j < pointsSize; j++) {
            int x_diff = points[j][0] - queries[i][0];
            int y_diff = points[j][1] - queries[i][1];
            if (x_diff * x_diff + y_diff * y_diff <= queries[i][2] * queries[i][2]) {
                count++;
            }
        }
        result[i] = count;
    }
    return result;
}