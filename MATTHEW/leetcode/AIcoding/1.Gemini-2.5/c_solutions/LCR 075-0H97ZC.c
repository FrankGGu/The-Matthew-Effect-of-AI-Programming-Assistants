#include <stdlib.h>
#include <string.h>

int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int counts[1001];
    memset(counts, 0, sizeof(counts));

    for (int i = 0; i < arr1Size; i++) {
        counts[arr1[i]]++;
    }

    int* result = (int*)malloc(sizeof(int) * arr1Size);
    *returnSize = arr1Size;
    int k = 0;

    for (int i = 0; i < arr2Size; i++) {
        int val = arr2[i];
        while (counts[val] > 0) {
            result[k++] = val;
            counts[val]--;
        }
    }

    for (int val = 0; val <= 1000; val++) {
        while (counts[val] > 0) {
            result[k++] = val;
            counts[val]--;
        }
    }

    return result;
}