#include <stdio.h>
#include <stdlib.h>

int countTriplets(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        int xor_i = 0;
        for (int j = i + 1; j < arrSize; j++) {
            xor_i ^= arr[j];
            int xor_j = 0;
            for (int k = j + 1; k < arrSize; k++) {
                xor_j ^= arr[k];
                if (xor_i == xor_j) {
                    count++;
                }
            }
        }
    }
    return count;
}