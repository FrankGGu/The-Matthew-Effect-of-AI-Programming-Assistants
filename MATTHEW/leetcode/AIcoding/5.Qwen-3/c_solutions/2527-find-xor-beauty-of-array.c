#include <stdio.h>
#include <stdlib.h>

int xorBeauty(int* arr, int arrSize) {
    int result = 0;
    for (int i = 0; i < arrSize; ++i) {
        int count = 0;
        for (int j = 0; j < arrSize; ++j) {
            if ((arr[i] & arr[j]) != 0) {
                count++;
            }
        }
        result ^= (arr[i] * count);
    }
    return result;
}