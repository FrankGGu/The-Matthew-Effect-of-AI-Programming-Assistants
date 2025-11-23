#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void duplicateZeros(int* arr, int arrSize) {
    int zeros = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 0) {
            zeros++;
        }
    }

    int len = arrSize + zeros;
    for (int i = arrSize - 1; i >= 0; i--) {
        if (arr[i] == 0) {
            if (i + zeros < arrSize) {
                arr[i + zeros] = 0;
            }
            zeros--;
            if (i + zeros < arrSize) {
                arr[i + zeros] = 0;
            }
        } else {
            if (i + zeros < arrSize) {
                arr[i + zeros] = arr[i];
            }
        }
    }
}