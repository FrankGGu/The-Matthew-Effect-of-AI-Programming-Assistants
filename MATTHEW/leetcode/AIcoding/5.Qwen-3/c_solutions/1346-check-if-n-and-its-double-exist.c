#include <stdio.h>
#include <stdlib.h>

bool checkIfExist(int* arr, int arrSize) {
    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (i != j && (arr[i] == 2 * arr[j] || arr[j] == 2 * arr[i])) {
                return true;
            }
        }
    }
    return false;
}