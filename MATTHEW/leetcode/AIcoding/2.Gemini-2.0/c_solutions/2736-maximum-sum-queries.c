#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maximumSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int max_sum = -1;
        for (int j = 0; j < nums1Size; j++) {
            if (nums1[j] >= queries[i][0] && nums2[j] >= queries[i][1]) {
                int current_sum = nums1[j] + nums2[j];
                if (current_sum > max_sum) {
                    max_sum = current_sum;
                }
            }
        }
        result[i] = max_sum;
    }

    return result;
}