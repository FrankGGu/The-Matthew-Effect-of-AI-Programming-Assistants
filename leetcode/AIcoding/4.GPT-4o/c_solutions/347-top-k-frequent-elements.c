#include <stdlib.h>

struct Element {
    int num;
    int count;
};

int cmp(const void *a, const void *b) {
    return ((struct Element *)b)->count - ((struct Element *)a)->count;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int *freq = calloc(numsSize, sizeof(int));
    struct Element *elements = malloc(numsSize * sizeof(struct Element));
    int uniqueCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i] + 10000] == 0) {
            elements[uniqueCount].num = nums[i];
            uniqueCount++;
        }
        freq[nums[i] + 10000]++;
    }

    for (int i = 0; i < uniqueCount; i++) {
        elements[i].count = freq[elements[i].num + 10000];
    }

    qsort(elements, uniqueCount, sizeof(struct Element), cmp);

    int *result = malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = elements[i].num;
    }

    free(freq);
    free(elements);
    *returnSize = k;
    return result;
}