#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int original_idx;
} Element;

int compareElements(const void *a, const void *b) {
    return ((Element *)b)->val - ((Element *)a)->val;
}

int compareIndices(const void *a, const void *b) {
    return ((Element *)a)->original_idx - ((Element *)b)->original_idx;
}

int* maxSubsequence(int* nums, int numsSize, int k, int* returnSize) {
    Element* elements = (Element*)malloc(numsSize * sizeof(Element));
    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].original_idx = i;
    }

    qsort(elements, numsSize, sizeof(Element), compareElements);

    Element* topK = (Element*)malloc(k * sizeof(Element));
    for (int i = 0; i < k; i++) {
        topK[i] = elements[i];
    }

    qsort(topK, k, sizeof(Element), compareIndices);

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = topK[i].val;
    }

    *returnSize = k;
    free(elements);
    free(topK);
    return result;
}