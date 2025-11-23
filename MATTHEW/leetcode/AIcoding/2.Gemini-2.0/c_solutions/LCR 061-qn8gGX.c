#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int sum;
    int i;
    int j;
} PairSum;

int compare(const void *a, const void *b) {
    return ((PairSum *)a)->sum - ((PairSum *)b)->sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    int totalPairs = nums1Size * nums2Size;
    if (totalPairs == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    PairSum* pairSums = (PairSum*)malloc(totalPairs * sizeof(PairSum));
    if (pairSums == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int index = 0;
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            pairSums[index].sum = nums1[i] + nums2[j];
            pairSums[index].i = i;
            pairSums[index].j = j;
            index++;
        }
    }

    qsort(pairSums, totalPairs, sizeof(PairSum), compare);

    int numPairs = (k < totalPairs) ? k : totalPairs;
    *returnSize = numPairs;
    *returnColumnSizes = (int*)malloc(numPairs * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(pairSums);
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(numPairs * sizeof(int*));
    if (result == NULL) {
        free(pairSums);
        free(*returnColumnSizes);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < numPairs; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        if (result[i] == NULL) {
            free(pairSums);
            free(*returnColumnSizes);
            for (int j = 0; j < i; j++) {
                free(result[j]);
            }
            free(result);
            *returnSize = 0;
            return NULL;
        }
        result[i][0] = nums1[pairSums[i].i];
        result[i][1] = nums2[pairSums[i].j];
        (*returnColumnSizes)[i] = 2;
    }

    free(pairSums);
    return result;
}