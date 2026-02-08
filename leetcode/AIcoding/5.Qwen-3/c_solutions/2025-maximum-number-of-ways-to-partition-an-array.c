#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxNumberofWays(int* array, int arraySize) {
    int* prefix = (int*)malloc(arraySize * sizeof(int));
    prefix[0] = array[0];
    for (int i = 1; i < arraySize; i++) {
        prefix[i] = prefix[i - 1] + array[i];
    }

    int* sortedPrefix = (int*)malloc((arraySize + 1) * sizeof(int));
    for (int i = 0; i <= arraySize; i++) {
        sortedPrefix[i] = prefix[i];
    }
    qsort(sortedPrefix, arraySize + 1, sizeof(int), compare);

    int count = 0;
    for (int i = 0; i < arraySize; i++) {
        int leftSum = prefix[i];
        int rightSum = prefix[arraySize - 1] - leftSum;

        int target = rightSum - leftSum;
        int low = 0, high = arraySize;
        while (low < high) {
            int mid = (low + high) / 2;
            if (sortedPrefix[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        if (low < arraySize && sortedPrefix[low] == target) {
            count++;
        }
    }

    free(prefix);
    free(sortedPrefix);
    return count;
}