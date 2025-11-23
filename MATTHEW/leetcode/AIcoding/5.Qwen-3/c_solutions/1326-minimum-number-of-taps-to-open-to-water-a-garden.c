#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minTaps(int* n, int size) {
    int* arr = (int*)malloc((size + 1) * sizeof(int));
    for (int i = 0; i <= size; i++) {
        arr[i] = 0;
    }
    for (int i = 0; i < size; i++) {
        int start = (i - n[i]) < 0 ? 0 : i - n[i];
        int end = (i + n[i]) > size ? size : i + n[i];
        arr[start] = (arr[start] > end) ? arr[start] : end;
    }
    int res = 0;
    int curr_end = 0;
    int next_end = 0;
    for (int i = 0; i < size; i++) {
        if (i > curr_end) {
            return -1;
        }
        next_end = (next_end > arr[i]) ? next_end : arr[i];
        if (i == curr_end) {
            res++;
            curr_end = next_end;
        }
    }
    free(arr);
    return res;
}