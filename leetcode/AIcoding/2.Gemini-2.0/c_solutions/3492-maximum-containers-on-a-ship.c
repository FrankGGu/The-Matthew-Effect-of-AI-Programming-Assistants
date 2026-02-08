#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxContainers(int* arr, int arrSize, int weightCap) {
    int count = 0;
    qsort(arr, arrSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    for (int i = 0; i < arrSize; i++) {
        if (weightCap >= arr[i]) {
            weightCap -= arr[i];
            count++;
        } else {
            break;
        }
    }

    return count;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}