#include <stdlib.h>
#include <stdbool.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

bool canReorderDoubled(int* arr, int arrSize) {
    if (arrSize % 2 != 0) return false;

    qsort(arr, arrSize, sizeof(int), cmp);
    int* count = calloc(arrSize, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        if (count[i] == 1) continue;

        int doubleValue = arr[i] * 2;
        int j = i + 1;
        while (j < arrSize && arr[j] < doubleValue) j++;

        if (j == arrSize || arr[j] != doubleValue || count[j] == 1) {
            free(count);
            return false;
        }

        count[i] = 1;
        count[j] = 1;
    }

    free(count);
    return true;
}