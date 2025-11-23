#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int abs_diff(int a, int b) {
    return (a > b) ? (a - b) : (b - a);
}

int compare_strongness(const void *a, const void *b, void *median) {
    int num_a = *(int*)a;
    int num_b = *(int*)b;
    int med = *(int*)median;

    int abs_a = abs_diff(num_a, med);
    int abs_b = abs_diff(num_b, med);

    if (abs_a != abs_b) {
        return abs_b - abs_a;
    } else {
        return num_b - num_a;
    }
}

int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);

    int median = arr[(arrSize - 1) / 2];

    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;

    int* temp_arr = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        temp_arr[i] = arr[i];
    }

    qsort_r(temp_arr, arrSize, sizeof(int), compare_strongness, &median);

    for (int i = 0; i < k; i++) {
        result[i] = temp_arr[i];
    }

    free(temp_arr);
    return result;
}