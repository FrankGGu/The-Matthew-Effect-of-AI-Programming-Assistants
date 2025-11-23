#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int num;
    int count;
} Element;

int cmp(const void *a, const void *b) {
    return ((Element *)b)->count - ((Element *)a)->count;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    int hashMap[20001] = {0};
    for (int i = 0; i < numsSize; i++) {
        hashMap[nums[i] + 10000]++;
    }

    Element* elements = malloc(20001 * sizeof(Element));
    int index = 0;
    for (int i = 0; i < 20001; i++) {
        if (hashMap[i] > 0) {
            elements[index].num = i - 10000;
            elements[index].count = hashMap[i];
            index++;
        }
    }

    qsort(elements, index, sizeof(Element), cmp);

    int* result = malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = elements[i].num;
    }

    free(elements);
    *returnSize = k;
    return result;
}