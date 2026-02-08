#include <stdio.h>
#include <stdlib.h>

int* mostVisited(int n, int* rounds, int roundsSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int count = 0;
    int start = rounds[0];
    int end = rounds[roundsSize - 1];

    if (start <= end) {
        for (int i = start; i <= end; i++) {
            result[count++] = i;
        }
    } else {
        for (int i = 1; i <= end; i++) {
            result[count++] = i;
        }
        for (int i = start; i <= n; i++) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}