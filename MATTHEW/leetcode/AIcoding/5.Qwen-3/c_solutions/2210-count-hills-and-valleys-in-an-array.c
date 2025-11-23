#include <stdio.h>
#include <stdlib.h>

int countHillValley(int* arr, int arrSize) {
    int count = 0;
    for (int i = 1; i < arrSize - 1; i++) {
        if ((arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) || (arr[i] < arr[i - 1] && arr[i] < arr[i + 1])) {
            count++;
        }
    }
    return count;
}