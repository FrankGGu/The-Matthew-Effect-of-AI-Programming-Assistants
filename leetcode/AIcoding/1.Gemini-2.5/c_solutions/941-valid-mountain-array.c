#include <stdbool.h>

bool validMountainArray(int* arr, int arrSize) {
    if (arrSize < 3) {
        return false;
    }

    int i = 0;

    // Walk up the mountain
    while (i + 1 < arrSize && arr[i] < arr[i + 1]) {
        i++;
    }

    // Peak cannot be the first or the last element
    if (i == 0 || i == arrSize - 1) {
        return false;
    }

    // Walk down the mountain
    while (i + 1 < arrSize && arr[i] > arr[i + 1]) {
        i++;
    }

    // If we reached the end of the array, it's a valid mountain
    return i == arrSize - 1;
}