#include <stdio.h>
#include <stdlib.h>

int* numMovesStonesToConsecutive(int a, int b, int c, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int x = a, y = b, z = c;
    if (x > y) { int t = x; x = y; y = t; }
    if (y > z) { int t = y; y = z; z = t; }
    if (x > y) { int t = x; x = y; y = t; }

    int min_moves = 0;
    if (y - x == 1 && z - y == 1) {
        min_moves = 0;
    } else if (y - x <= 2 || z - y <= 2) {
        min_moves = 1;
    } else {
        min_moves = 2;
    }

    int max_moves = (z - x - 2);
    result[0] = min_moves;
    result[1] = max_moves;
    return result;
}