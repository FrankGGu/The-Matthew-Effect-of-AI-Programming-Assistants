#include <stdio.h>
#include <stdlib.h>

int sumOddLengthSubarrays(int* arr, int arrSize) {
    int sum = 0;
    for (int i = 0; i < arrSize; i++) {
        int count = 0;
        for (int j = i; j < arrSize; j++) {
            count++;
            if (count % 2 == 1) {
                for (int k = i; k <= j; k++) {
                    sum += arr[k];
                }
            }
        }
    }
    return sum;
}