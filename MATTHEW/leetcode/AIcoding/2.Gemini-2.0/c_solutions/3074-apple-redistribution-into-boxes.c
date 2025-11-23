#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int redistributeApples(int* boxSizes, int boxSizesSize, int applesSize, int* apples) {
    int count = 0;
    for (int i = 0; i < applesSize; i++) {
        int apple = apples[i];
        for (int j = 0; j < boxSizesSize; j++) {
            if (boxSizes[j] >= apple) {
                boxSizes[j] -= apple;
                count++;
                break;
            }
        }
    }
    return count;
}