#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numMovesStones(int a, int b, int c, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    int stones[3] = {a, b, c};
    qsort(stones, 3, sizeof(int), compare);

    int x = stones[0];
    int y = stones[1];
    int z = stones[2];

    result[1] = (y - x - 1) + (z - y - 1);

    if (y - x == 1 && z - y == 1) {
        result[0] = 0;
    } else if (y - x <= 2 || z - y <= 2) {
        result[0] = 1;
    } else {
        result[0] = 2;
    }

    return result;
}