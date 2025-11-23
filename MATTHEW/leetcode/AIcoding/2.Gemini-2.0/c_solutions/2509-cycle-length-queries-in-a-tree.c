#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* cycleLengthQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int node1 = queries[i][0];
        int node2 = queries[i][1];
        int length = 1;

        while (node1 != node2) {
            if (node1 > node2) {
                node1 /= 2;
            } else {
                node2 /= 2;
            }
            length++;
        }
        result[i] = length;
    }

    return result;
}