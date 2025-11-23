#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int sum;
    int i;
    int j;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)a)->sum - ((Pair*)b)->sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int** returnSize) {
    int** result = (int**)malloc(sizeof(int*) * k);
    Pair* pairs = (Pair*)malloc(sizeof(Pair) * nums1Size * nums2Size);
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            pairs[count].sum = nums1[i] + nums2[j];
            pairs[count].i = i;
            pairs[count].j = j;
            count++;
        }
    }

    qsort(pairs, count, sizeof(Pair), cmp);

    *returnSize = k < count ? k : count;
    for (int i = 0; i < *returnSize; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = nums1[pairs[i].i];
        result[i][1] = nums2[pairs[i].j];
    }

    free(pairs);
    return result;
}