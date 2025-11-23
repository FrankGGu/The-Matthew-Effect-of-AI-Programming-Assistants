#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double trimMean(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), compare);

    int num_to_remove = arrSize / 20; // 5% of arrSize

    long long sum = 0;
    int count = 0;

    for (int i = num_to_remove; i < arrSize - num_to_remove; i++) {
        sum += arr[i];
        count++;
    }

    return (double)sum / count;
}