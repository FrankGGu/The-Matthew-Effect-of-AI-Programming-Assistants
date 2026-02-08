#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} DynamicArray;

void insertElementAtBeginning(DynamicArray* arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity = arr->capacity == 0 ? 4 : arr->capacity * 2;
        arr->data = (int*)realloc(arr->data, arr->capacity * sizeof(int));
    }
    if (arr->size > 0) {
        memmove(arr->data + 1, arr->data, arr->size * sizeof(int));
    }
    arr->data[0] = val;
    arr->size++;
}

void freeDynamicArray(DynamicArray* arr) {
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

int* findDiagonalOrder(int** nums, int numsSize, int* numsColSizes, int* returnSize) {
    const int MAX_SUM_POSSIBLE = 100005; 

    DynamicArray* diagonals_storage = (DynamicArray*)calloc(MAX_SUM_POSSIBLE, sizeof(DynamicArray));

    int total_elements = 0;

    for (int r = 0; r < numsSize; r++) {
        for (int c = 0; c < numsColSizes[r]; c++) {
            int sum = r + c;
            insertElementAtBeginning(&diagonals_storage[sum], nums[r][c]);
            total_elements++;
        }
    }

    int* result = (int*)malloc(total_elements * sizeof(int));
    int current_idx = 0;

    for (int i = 0; i < MAX_SUM_POSSIBLE; i++) {
        for (int j = 0; j < diagonals_storage[i].size; j++) {
            result[current_idx++] = diagonals_storage[i].data[j];
        }
    }

    *returnSize = total_elements;

    for (int i = 0; i < MAX_SUM_POSSIBLE; i++) {
        freeDynamicArray(&diagonals_storage[i]);
    }
    free(diagonals_storage);

    return result;
}