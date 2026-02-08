#include <stdio.h>
#include <stdlib.h>

int minDeletions(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            count++;
        }
    }
    return count;
}