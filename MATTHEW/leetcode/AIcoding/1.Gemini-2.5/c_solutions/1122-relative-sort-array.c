#include <stdlib.h>

#define MAX_VAL 1001

int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int freq[MAX_VAL] = {0};

    for (int i = 0; i < arr1Size; i++) {
        freq[arr1[i]]++;
    }

    int* result = (int*)malloc(arr1Size * sizeof(int));
    int current_idx = 0;

    for (int i = 0; i < arr2Size; i++) {
        int val = arr2[i];
        while (freq[val] > 0) {
            result[current_idx++] = val;
            freq[val]--;
        }
    }

    for (int val = 0; val < MAX_VAL; val++) {
        while (freq[val] > 0) {
            result[current_idx++] = val;
            freq[val]--;
        }
    }

    *returnSize = arr1Size;
    return result;
}