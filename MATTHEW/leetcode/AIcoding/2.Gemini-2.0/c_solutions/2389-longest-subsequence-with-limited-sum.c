#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int* answerQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int *prefix_sum = (int*)malloc(numsSize * sizeof(int));
    prefix_sum[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefix_sum[i] = prefix_sum[i-1] + nums[i];
    }

    int *result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int left = 0, right = numsSize - 1;
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (prefix_sum[mid] <= query) {
                ans = mid + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result[i] = ans;
    }

    free(prefix_sum);
    return result;
}