#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(int* target, int targetSize, int* arr, int arrSize){
    if (targetSize != arrSize) return false;
    int count[1001] = {0};
    for (int i = 0; i < targetSize; i++) {
        count[target[i]]++;
        count[arr[i]]--;
    }
    for (int i = 0; i <= 1000; i++) {
        if (count[i] != 0) return false;
    }
    return true;
}