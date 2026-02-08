#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minSetSize(int* arr, int arrSize){
    int* count = (int*)malloc(sizeof(int) * 1001);
    for (int i = 0; i < 1001; i++) {
        count[i] = 0;
    }
    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]++;
    }
    qsort(count, 1001, sizeof(int), compare);
    int total = 0;
    int size = 0;
    for (int i = 0; i < 1001; i++) {
        if (count[i] == 0) continue;
        total += count[i];
        size++;
        if (total >= arrSize / 2) {
            free(count);
            return size;
        }
    }
    free(count);
    return size;
}