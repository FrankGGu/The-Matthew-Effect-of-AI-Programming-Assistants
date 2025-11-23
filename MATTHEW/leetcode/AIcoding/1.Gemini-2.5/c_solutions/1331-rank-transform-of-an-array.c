#include <stdlib.h>
#include <limits.h>

struct Element {
    int value;
    int original_index;
};

int compareElements(const void* a, const void* b) {
    return ((struct Element*)a)->value - ((struct Element*)b)->value;
}

int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    if (arrSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    struct Element* elements = (struct Element*)malloc(arrSize * sizeof(struct Element));
    if (elements == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < arrSize; i++) {
        elements[i].value = arr[i];
        elements[i].original_index = i;
    }

    qsort(elements, arrSize, sizeof(struct Element), compareElements);

    int* result = (int*)malloc(arrSize * sizeof(int));
    if (result == NULL) {
        free(elements);
        *returnSize = 0;
        return NULL;
    }

    int current_rank = 0;
    int prev_value = INT_MIN;

    for (int i = 0; i < arrSize; i++) {
        if (elements[i].value != prev_value) {
            current_rank++;
            prev_value = elements[i].value;
        }
        result[elements[i].original_index] = current_rank;
    }

    free(elements);
    *returnSize = arrSize;
    return result;
}