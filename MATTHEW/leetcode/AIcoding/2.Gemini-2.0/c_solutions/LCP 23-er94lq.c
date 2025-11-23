#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isMagic(int* target, int targetSize) {
    int arr[targetSize];
    for (int i = 0; i < targetSize; i++) {
        arr[i] = i % 2 == 0 ? i / 2 : targetSize - 1 - i / 2;
    }

    for (int i = 0; i < targetSize; i++) {
        if (arr[i] != target[i]) {
            return false;
        }
    }

    return true;
}