#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findPeaks(int arr[], int size) {
    int count = 0;
    if (size < 3) {
        return 0;
    }

    for (int i = 1; i < size - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            count++;
        }
    }

    return count;
}