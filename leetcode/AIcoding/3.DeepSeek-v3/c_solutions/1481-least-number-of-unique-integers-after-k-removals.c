#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findLeastNumOfUniqueInts(int* arr, int arrSize, int k) {
    qsort(arr, arrSize, sizeof(int), compare);

    int *freq = (int*)malloc(arrSize * sizeof(int));
    int freqSize = 0;

    int count = 1;
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] == arr[i-1]) {
            count++;
        } else {
            freq[freqSize++] = count;
            count = 1;
        }
    }
    freq[freqSize++] = count;

    qsort(freq, freqSize, sizeof(int), compare);

    int uniqueCount = freqSize;
    for (int i = 0; i < freqSize; i++) {
        if (k >= freq[i]) {
            k -= freq[i];
            uniqueCount--;
        } else {
            break;
        }
    }

    free(freq);
    return uniqueCount;
}