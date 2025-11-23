#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countTriplets(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            for (int k = j; k < arrSize; k++) {
                int a = 0;
                for (int l = i; l < j; l++) {
                    a ^= arr[l];
                }
                int b = 0;
                for (int l = j; l <= k; l++) {
                    b ^= arr[l];
                }
                if (a == b) {
                    count++;
                }
            }
        }
    }
    return count;
}