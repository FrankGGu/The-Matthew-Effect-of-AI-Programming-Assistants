#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int index;
    int value;
} Pair;

int compare(const void* a, const void* b) {
    return ((Pair*)b)->value - ((Pair*)a)->value;
}

int* maximumSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int* queries, int queriesSize, int* returnSize) {
    int n = nums1Size;
    int q = queriesSize;
    Pair* pairs = (Pair*)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        pairs[i].index = i;
        pairs[i].value = nums1[i] + nums2[i];
    }
    qsort(pairs, n, sizeof(Pair), compare);

    int* result = (int*)malloc(q * sizeof(int));
    for (int i = 0; i < q; i++) {
        int maxSum = -1;
        for (int j = 0; j < n; j++) {
            if (nums2[pairs[j].index] >= queries[i]) {
                maxSum = (maxSum < pairs[j].value) ? pairs[j].value : maxSum;
            }
        }
        result[i] = maxSum;
    }
    *returnSize = q;
    free(pairs);
    return result;
}