#include <stdio.h>
#include <stdlib.h>

int* mostBooked(int n, int m, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) result[i] = 0;

    int* rooms = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) rooms[i] = 0;

    for (int i = 0; i < queriesSize; i++) {
        int room = queries[i][0];
        int time = queries[i][1];
        result[room] += time;
        rooms[room] += time;
    }

    *returnSize = n;
    return result;
}