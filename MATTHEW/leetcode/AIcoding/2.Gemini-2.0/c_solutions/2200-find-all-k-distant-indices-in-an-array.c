#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findKDistantIndices(int* nums, int numsSize, int key, int k, int* returnSize){
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] == key && abs(i - j) <= k) {
                bool found = false;
                for (int l = 0; l < *returnSize; l++) {
                    if (result[l] == i) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    result[*returnSize] = i;
                    (*returnSize)++;
                }
                break;
            }
        }
    }

    int* finalResult = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        finalResult[i] = result[i];
    }
    free(result);

    return finalResult;
}