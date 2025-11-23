#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val1;
    int val2;
    int sum;
    int index1;
    int index2;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)a)->sum - ((Pair *)b)->sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes){
    int len = nums1Size * nums2Size;
    if (len == 0) {
        *returnSize = 0;
        return NULL;
    }

    Pair* pairs = (Pair*)malloc(len * sizeof(Pair));
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            pairs[i * nums2Size + j].val1 = nums1[i];
            pairs[i * nums2Size + j].val2 = nums2[j];
            pairs[i * nums2Size + j].sum = nums1[i] + nums2[j];
            pairs[i * nums2Size + j].index1 = i;
            pairs[i * nums2Size + j].index2 = j;
        }
    }

    qsort(pairs, len, sizeof(Pair), compare);

    *returnSize = (k < len) ? k : len;
    int** result = (int**)malloc((*returnSize) * sizeof(int*));
    *returnColumnSizes = (int*)malloc((*returnSize) * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = pairs[i].val1;
        result[i][1] = pairs[i].val2;
        (*returnColumnSizes)[i] = 2;
    }

    free(pairs);
    return result;
}