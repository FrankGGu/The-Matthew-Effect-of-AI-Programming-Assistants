#include <stdio.h>
#include <stdlib.h>

int* relocateMarbles(int* marbles, int marblesSize, int* moveFrom, int moveFromSize, int* moveTo, int moveToSize, int* returnSize) {
    int* result = (int*)malloc(marblesSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < marblesSize; i++) {
        int found = 0;
        for (int j = 0; j < moveFromSize; j++) {
            if (marbles[i] == moveFrom[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            result[index++] = marbles[i];
        }
    }

    *returnSize = index;
    return result;
}