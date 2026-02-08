#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int value;
    int original_index;
} Element;

int compareElements(const void *a, const void *b) {
    Element *elemA = (Element *)a;
    Element *elemB = (Element *)b;

    if (elemA->value != elemB->value) {
        return elemA->value - elemB->value;
    }
    return elemA->original_index - elemB->original_index;
}

long long findScore(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    Element* elements = (Element*)malloc(numsSize * sizeof(Element));

    for (int i = 0; i < numsSize; i++) {
        elements[i].value = nums[i];
        elements[i].original_index = i;
    }

    qsort(elements, numsSize, sizeof(Element), compareElements);

    bool* marked = (bool*)calloc(numsSize, sizeof(bool)); 

    long long totalScore = 0;

    for (int i = 0; i < numsSize; i++) {
        int current_value = elements[i].value;
        int original_idx = elements[i].original_index;

        if (!marked[original_idx]) {
            totalScore += current_value;
            marked[original_idx] = true;

            if (original_idx > 0) {
                marked[original_idx - 1] = true;
            }
            if (original_idx < numsSize - 1) {
                marked[original_idx + 1] = true;
            }
        }
    }

    free(elements);
    free(marked);

    return totalScore;
}