#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double trimMean(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), compare);
    int remove_count = arrSize * 0.05;
    double sum = 0.0;
    for (int i = remove_count; i < arrSize - remove_count; i++) {
        sum += arr[i];
    }
    return sum / (arrSize - 2 * remove_count);
}