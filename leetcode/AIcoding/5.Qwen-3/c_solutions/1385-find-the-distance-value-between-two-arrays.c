#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int target) {
    qsort(arr2, arr2Size, sizeof(int), compare);
    int distance = 0;
    for (int i = 0; i < arr1Size; i++) {
        int valid = 1;
        for (int j = 0; j < arr2Size; j++) {
            if (abs(arr1[i] - arr2[j]) <= target) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            distance++;
        }
    }
    return distance;
}