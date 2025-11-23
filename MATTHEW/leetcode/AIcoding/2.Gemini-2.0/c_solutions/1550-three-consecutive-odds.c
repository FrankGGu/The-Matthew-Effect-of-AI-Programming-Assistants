#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool threeConsecutiveOdds(int* arr, int arrSize){
    if (arrSize < 3) {
        return false;
    }
    for (int i = 0; i < arrSize - 2; i++) {
        if (arr[i] % 2 != 0 && arr[i+1] % 2 != 0 && arr[i+2] % 2 != 0) {
            return true;
        }
    }
    return false;
}