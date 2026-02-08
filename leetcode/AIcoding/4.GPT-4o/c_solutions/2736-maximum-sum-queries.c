#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int value, index;
} Element;

int cmp(const void *a, const void *b) {
    return ((Element *)b)->value - ((Element *)a)->value;
}

int* maxSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int* queries, int queriesSize, int* returnSize) {
    Element* elements = (Element*)malloc(nums1Size * sizeof(Element));
    for (int i = 0; i < nums1Size; i++) {
        elements[i].value = nums1[i];
        elements[i].index = i;
    }
    qsort(elements, nums1Size, sizeof(Element), cmp);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* maxPrefixSum = (int*)calloc(nums1Size + 1, sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        maxPrefixSum[i + 1] = maxPrefixSum[i] + elements[i].value;
    }

    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i];
        int sum = 0;
        for (int j = 0; j < nums1Size; j++) {
            if (nums2[elements[j].index] > q) break;
            sum += elements[j].value;
        }
        result[i] = sum;
    }

    free(elements);
    free(maxPrefixSum);
    *returnSize = queriesSize;
    return result;
}