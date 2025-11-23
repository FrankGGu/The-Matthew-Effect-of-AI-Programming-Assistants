#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* intersectionOfMultipleArrays(int** arrays, int arraysSize, int* arraySizes, int* returnSize) {
    int* freq = (int*)calloc(1001, sizeof(int));
    int i, j;

    for (i = 0; i < arraysSize; i++) {
        int* arr = arrays[i];
        int size = arraySizes[i];
        int* seen = (int*)calloc(size, sizeof(int));

        for (j = 0; j < size; j++) {
            if (!seen[arr[j]]) {
                freq[arr[j]]++;
                seen[arr[j]] = 1;
            }
        }

        free(seen);
    }

    int count = 0;
    for (i = 0; i <= 1000; i++) {
        if (freq[i] == arraysSize) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;

    for (i = 0; i <= 1000; i++) {
        if (freq[i] == arraysSize) {
            result[index++] = i;
        }
    }

    free(freq);
    *returnSize = count;
    return result;
}