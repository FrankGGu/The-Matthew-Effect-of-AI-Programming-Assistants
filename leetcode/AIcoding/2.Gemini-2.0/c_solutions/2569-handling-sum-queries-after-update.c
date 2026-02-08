#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* handleQuery(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long* res = (long long*)malloc(sizeof(long long) * queriesSize);
    *returnSize = 0;
    long long sum = 0;
    for (int i = 0; i < nums2Size; i++) {
        sum += nums2[i];
    }
    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 1) {
            int l = queries[i][1];
            int r = queries[i][2];
            for (int j = l; j <= r; j++) {
                nums1[j] = 1 - nums1[j];
            }
        } else if (queries[i][0] == 2) {
            int p = queries[i][1];
            for (int j = 0; j < nums1Size; j++) {
                sum += (long long)nums1[j] * p;
            }
        } else {
            res[*returnSize] = sum;
            (*returnSize)++;
        }
    }
    return res;
}