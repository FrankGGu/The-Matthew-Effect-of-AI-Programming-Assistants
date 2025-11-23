#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minRemovals(int* arr, int n) {
    int* sorted = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        sorted[i] = arr[i];
    }
    qsort(sorted, n, sizeof(int), compare);

    int count = 0;
    int i = 0, j = 0;
    while (i < n && j < n) {
        if (arr[i] == sorted[j]) {
            i++;
            j++;
        } else {
            count++;
            i++;
        }
    }
    free(sorted);
    return count;
}