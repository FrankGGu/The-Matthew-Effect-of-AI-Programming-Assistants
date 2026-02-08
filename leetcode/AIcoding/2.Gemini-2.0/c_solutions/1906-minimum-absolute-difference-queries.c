#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* minDifference(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];
        int min_diff = INT_MAX;
        int last_val = -1;
        int seen[101] = {0};
        int values[numsSize];
        int values_size = 0;

        for (int j = start; j <= end; j++) {
            if(seen[nums[j]] == 0){
                values[values_size++] = nums[j];
                seen[nums[j]] = 1;
            }
        }

        if (values_size < 2) {
            result[i] = -1;
            continue;
        }

        for (int j = 0; j < values_size; j++) {
            for(int k = j + 1; k < values_size; k++){
                int diff = abs(values[j] - values[k]);
                if(diff < min_diff){
                    min_diff = diff;
                }
            }
        }

        if(min_diff == INT_MAX){
            result[i] = -1;
        } else {
            result[i] = min_diff;
        }

    }

    return result;
}