#include <stdio.h>
#include <stdlib.h>

bool validMountainArray(int* arr, int arrSize) {
    if (arrSize < 3) return false;

    int i = 0;

    // Walk up
    while (i + 1 < arrSize && arr[i] < arr[i + 1]) {
        i++;
    }

    // Peak can't be first or last
    if (i == 0 || i == arrSize - 1) return false;

    // Walk down
    while (i + 1 < arrSize && arr[i] > arr[i + 1]) {
        i++;
    }

    return i == arrSize - 1;
}