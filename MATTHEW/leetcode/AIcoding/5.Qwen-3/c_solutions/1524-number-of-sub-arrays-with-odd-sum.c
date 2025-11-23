#include <stdio.h>
#include <stdlib.h>

int sumOddLengthSubarrays(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i; j < arrSize; j++) {
            int sum = 0;
            for (int k = i; k <= j; k++) {
                sum += arr[k];
            }
            if (sum % 2 == 1) {
                count++;
            }
        }
    }
    return count;
}