#include <stdio.h>
#include <stdlib.h>

int maximumNumberOfDistinctElements(int* nums, int numsSize) {
    int* count = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int res = 0;
    for (int i = 0; i <= 10000; i++) {
        if (count[i] > 0) {
            res++;
            if (count[i] > 1) {
                res++;
            }
        }
    }

    free(count);
    return res;
}