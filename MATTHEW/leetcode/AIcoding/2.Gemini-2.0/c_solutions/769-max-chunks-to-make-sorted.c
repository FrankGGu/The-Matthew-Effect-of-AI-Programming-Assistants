#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxChunksToSorted(int* arr, int arrSize) {
    int max = 0;
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
        if (max == i) {
            count++;
        }
    }
    return count;
}