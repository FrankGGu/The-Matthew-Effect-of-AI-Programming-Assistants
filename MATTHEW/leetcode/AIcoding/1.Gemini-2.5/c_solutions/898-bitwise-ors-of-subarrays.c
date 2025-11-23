#include <stdlib.h> // For malloc, realloc, free, qsort

typedef struct {
    int* data;
    int size;
    int capacity;
} IntArray;

void initIntArray(IntArray* arr, int initialCapacity) {
    arr->data = (int*)malloc(sizeof(int) * initialCapacity);
    arr->size = 0;
    arr->capacity = initialCapacity;
}

void addInt(IntArray* arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, sizeof(int) * arr->capacity);
    }
    arr->data[arr->size++] = val;
}

void freeIntArray(IntArray* arr) {
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int bitwiseORsSubarrays(int* arr, int arrSize) {
    if (arrSize == 0) {
        return 0;
    }

    IntArray current_or_sums;
    initIntArray(&current_or_sums, 32); 

    IntArray total_unique_ors;
    initIntArray(&total_unique_ors, arrSize * 32); 

    for (int i = 0; i < arrSize; ++i) {
        IntArray next_or_sums;
        initIntArray(&next_or_sums, 32);

        addInt(&next_or_sums, arr[i]);

        for (int j = 0; j < current_or_sums.size; ++j) {
            addInt(&next_or_sums, arr[i] | current_or_sums.data[j]);
        }

        qsort(next_or_sums.data, next_or_sums.size, sizeof(int), compareInts);
        int unique_next_size = 0;
        if (next_or_sums.size > 0) {
            next_or_sums.data[unique_next_size++] = next_or_sums.data[0];
            for (int k = 1; k < next_or_sums.size; ++k) {
                if (next_or_sums.data[k] != next_or_sums.data[k-1]) {
                    next_or_sums.data[unique_next_size++] = next_or_sums.data[k];
                }
            }
        }
        next_or_sums.size = unique_next_size;

        current_or_sums.size = 0;
        for (int k = 0; k < next_or_sums.size; ++k) {
            addInt(&current_or_sums, next_or_sums.data[k]);
        }

        for (int k = 0; k < next_or_sums.size; ++k) {
            addInt(&total_unique_ors, next_or_sums.data[k]);
        }

        freeIntArray(&next_or_sums);
    }

    qsort(total_unique_ors.data, total_unique_ors.size, sizeof(int), compareInts);

    int unique_count = 0;
    if (total_unique_ors.size > 0) {
        unique_count = 1;
        for (int i = 1; i < total_unique_ors.size; ++i) {
            if (total_unique_ors.data[i] != total_unique_ors.data[i-1]) {
                unique_count++;
            }
        }
    }

    freeIntArray(&current_or_sums);
    freeIntArray(&total_unique_ors);

    return unique_count;
}