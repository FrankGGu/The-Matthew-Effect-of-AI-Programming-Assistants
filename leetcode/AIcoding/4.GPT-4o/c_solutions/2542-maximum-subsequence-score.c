#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

int maxScore(int* nums1, int* nums2, int numsSize, int k) {
    long long sum = 0, maxScore = 0;
    int *indices = (int *)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    qsort(indices, numsSize, sizeof(int), cmp);

    int *minHeap = (int *)malloc(k * sizeof(int));
    int minHeapSize = 0;

    for (int i = 0; i < k; i++) {
        sum += nums1[indices[i]];
        minHeap[minHeapSize++] = nums2[indices[i]];
    }

    long long minNum2 = nums2[indices[k - 1]];
    maxScore = sum * minNum2;

    for (int i = k; i < numsSize; i++) {
        sum += nums1[indices[i]] - nums1[indices[i - k]];
        minNum2 = fmin(minNum2, nums2[indices[i]]);
        maxScore = fmax(maxScore, sum * minNum2);
    }

    free(indices);
    free(minHeap);

    return maxScore;
}