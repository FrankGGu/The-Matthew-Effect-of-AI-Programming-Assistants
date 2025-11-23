#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long kSubarraySumEqual(int* arr, int arrSize, int k) {
    long long ans = 0;
    k = k % arrSize;
    if (k == 0) k = arrSize;
    for (int i = 0; i < k; i++) {
        int count = 0;
        int* subArr = (int*)malloc(sizeof(int) * (arrSize / k + 2));
        for (int j = i; j < arrSize; j += k) {
            subArr[count++] = arr[j];
        }
        qsort(subArr, count, sizeof(int), (int (*)(const void *, const void *))cmpfunc);
        int median = subArr[count / 2];
        for (int j = 0; j < count; j++) {
            ans += abs(subArr[j] - median);
        }
        free(subArr);
    }
    return ans;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}