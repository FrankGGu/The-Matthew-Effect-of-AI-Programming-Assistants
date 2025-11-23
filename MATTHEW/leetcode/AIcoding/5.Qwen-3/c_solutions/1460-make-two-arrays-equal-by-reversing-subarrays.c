#include <stdio.h>
#include <stdlib.h>

int canBeEqual(int* target, int targetSize, int* arr, int arrSize) {
    if (targetSize != arrSize) return 0;

    int count[1001] = {0};

    for (int i = 0; i < targetSize; i++) {
        count[target[i]]++;
        count[arr[i]]--;
    }

    for (int i = 0; i < 1001; i++) {
        if (count[i] != 0) return 0;
    }

    return 1;
}