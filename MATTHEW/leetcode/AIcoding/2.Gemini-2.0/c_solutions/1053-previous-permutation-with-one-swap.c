#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int* prevPermOpt1(int* arr, int arrSize, int* returnSize){
    int i = arrSize - 2;
    while (i >= 0 && arr[i] <= arr[i + 1]) {
        i--;
    }

    if (i < 0) {
        *returnSize = arrSize;
        return arr;
    }

    int j = arrSize - 1;
    while (arr[j] >= arr[i]) {
        j--;
    }

    while (arr[j] == arr[j - 1] && j > i) {
        j--;
    }

    swap(&arr[i], &arr[j]);
    *returnSize = arrSize;
    return arr;
}