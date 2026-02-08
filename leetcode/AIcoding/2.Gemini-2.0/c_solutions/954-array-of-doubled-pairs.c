#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canReorderDoubled(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), compare);
    int* seen = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        seen[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        if (seen[i]) continue;
        int target = arr[i] * 2;
        if (arr[i] < 0) target = arr[i] / 2;
        if (arr[i] < 0 && arr[i] % 2 != 0) continue;

        bool found = false;
        for (int j = 0; j < arrSize; j++) {
            if (i == j || seen[j]) continue;
            if (arr[j] == target) {
                seen[i] = 1;
                seen[j] = 1;
                found = true;
                break;
            }
        }
        if (!found) {
            free(seen);
            return false;
        }
    }

    free(seen);
    return true;
}