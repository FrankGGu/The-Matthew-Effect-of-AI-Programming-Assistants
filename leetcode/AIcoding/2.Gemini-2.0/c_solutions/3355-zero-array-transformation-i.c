#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(int* target, int targetSize, int* arr, int arrSize) {
    int count[1001] = {0};
    for (int i = 0; i < targetSize; i++) {
        count[target[i]]++;
    }
    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]--;
    }
    for (int i = 0; i <= 1000; i++) {
        if (count[i] != 0) {
            return false;
        }
    }
    return true;
}