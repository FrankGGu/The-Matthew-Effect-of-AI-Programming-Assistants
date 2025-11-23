#include <stdio.h>
#include <stdlib.h>

void duplicateZeros(int* arr, int arrSize) {
    int i = 0;
    while (i < arrSize) {
        if (arr[i] == 0) {
            for (int j = arrSize - 1; j > i; j--) {
                arr[j] = arr[j - 1];
            }
            i++;
        }
        i++;
    }
}