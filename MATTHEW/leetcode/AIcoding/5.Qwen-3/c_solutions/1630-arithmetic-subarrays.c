#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int* arithmeticSubarrays(int* nums, int numsSize, int* l, int lSize, int* r, int rSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * lSize);
    int index = 0;

    for (int i = 0; i < lSize; i++) {
        int left = l[i];
        int right = r[i];
        int length = right - left + 1;
        if (length < 2) {
            result[index++] = 1;
            continue;
        }

        int* subarray = (int*)malloc(sizeof(int) * length);
        for (int j = 0; j < length; j++) {
            subarray[j] = nums[left + j];
        }

        int isArithmetic = 1;
        int diff = subarray[1] - subarray[0];
        for (int j = 2; j < length; j++) {
            if (subarray[j] - subarray[j - 1] != diff) {
                isArithmetic = 0;
                break;
            }
        }

        result[index++] = isArithmetic;
        free(subarray);
    }

    *returnSize = index;
    return result;
}