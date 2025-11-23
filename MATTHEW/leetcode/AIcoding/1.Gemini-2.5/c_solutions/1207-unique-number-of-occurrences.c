#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool uniqueOccurrences(int* arr, int arrSize) {
    if (arrSize == 0) {
        return true;
    }

    qsort(arr, arrSize, sizeof(int), compareIntegers);

    int* occurrences = (int*)malloc(arrSize * sizeof(int));
    if (occurrences == NULL) {
        return false; 
    }
    int occCount = 0;

    int i = 0;
    while (i < arrSize) {
        int currentNum = arr[i];
        int count = 0;
        int j = i;
        while (j < arrSize && arr[j] == currentNum) {
            count++;
            j++;
        }
        occurrences[occCount++] = count;
        i = j;
    }

    qsort(occurrences, occCount, sizeof(int), compareIntegers);

    for (int k = 0; k < occCount - 1; k++) {
        if (occurrences[k] == occurrences[k+1]) {
            free(occurrences);
            return false;
        }
    }

    free(occurrences);
    return true;
}