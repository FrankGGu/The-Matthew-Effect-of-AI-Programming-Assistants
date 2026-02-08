#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minSetSize(int* arr, int arrSize) {
    int freq[100001] = {0}; 

    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    int* distinct_freqs = (int*)malloc(sizeof(int) * arrSize);
    int distinct_count = 0;
    for (int i = 1; i <= 100000; i++) {
        if (freq[i] > 0) {
            distinct_freqs[distinct_count++] = freq[i];
        }
    }

    qsort(distinct_freqs, distinct_count, sizeof(int), compare);

    int removed_elements_count = 0;
    int set_size = 0;
    int target_removed = (arrSize + 1) / 2;

    for (int i = 0; i < distinct_count; i++) {
        removed_elements_count += distinct_freqs[i];
        set_size++;
        if (removed_elements_count >= target_removed) {
            break;
        }
    }

    free(distinct_freqs);
    return set_size;
}