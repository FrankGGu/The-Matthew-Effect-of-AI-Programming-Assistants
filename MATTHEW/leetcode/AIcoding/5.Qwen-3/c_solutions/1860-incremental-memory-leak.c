#include <stdio.h>
#include <stdlib.h>

int* memoryLeak(int x, int y) {
    int* result = (int*)malloc(2 * sizeof(int));
    while (x >= y) {
        y++;
    }
    result[0] = y;
    result[1] = x - y + 1;
    return result;
}