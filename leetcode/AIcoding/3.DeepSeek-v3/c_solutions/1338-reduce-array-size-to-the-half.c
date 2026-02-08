#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int minSetSize(int* arr, int arrSize) {
    int freq[100001] = {0};
    int max_val = 0;

    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
    }

    int* frequencies = (int*)malloc(arrSize * sizeof(int));
    int freq_count = 0;

    for (int i = 0; i <= max_val; i++) {
        if (freq[i] > 0) {
            frequencies[freq_count++] = freq[i];
        }
    }

    qsort(frequencies, freq_count, sizeof(int), cmp);

    int target = arrSize / 2;
    int removed = 0;
    int count = 0;

    for (int i = 0; i < freq_count; i++) {
        removed += frequencies[i];
        count++;
        if (removed >= target) {
            break;
        }
    }

    free(frequencies);
    return count;
}