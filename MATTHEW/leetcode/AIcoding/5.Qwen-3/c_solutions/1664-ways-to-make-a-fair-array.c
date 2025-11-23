#include <stdio.h>
#include <stdlib.h>

int waysToMakeFair(int* arr, int arrSize) {
    int total = 0;
    for (int i = 0; i < arrSize; i++) {
        int leftSum = 0;
        int rightSum = 0;
        for (int j = 0; j < i; j++) {
            if (j % 2 == 0) {
                leftSum += arr[j];
            }
        }
        for (int j = i + 1; j < arrSize; j++) {
            if ((j - i - 1) % 2 == 0) {
                rightSum += arr[j];
            }
        }
        if (leftSum == rightSum) {
            total++;
        }
    }
    return total;
}