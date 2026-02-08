#include <stdio.h>
#include <stdlib.h>

int getWinner(int* arr, int arrSize, int k) {
    int current = arr[0];
    int count = 0;

    for (int i = 1; i < arrSize; i++) {
        if (current > arr[i]) {
            count++;
        } else {
            current = arr[i];
            count = 1;
        }

        if (count == k) {
            return current;
        }
    }

    return current;
}