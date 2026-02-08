#include <stdio.h>
#include <stdlib.h>

int minRemovals(int* arr, int n) {
    int count = 0;
    for (int i = 1; i < n; i++) {
        if (arr[i] < arr[i - 1]) {
            count++;
        }
    }
    return count;
}