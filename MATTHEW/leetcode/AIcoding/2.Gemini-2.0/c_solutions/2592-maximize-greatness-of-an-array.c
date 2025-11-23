#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximizeGreatness(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), cmp);
    int count = 0;
    int j = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > nums[j]) {
            count++;
            j++;
        }
    }
    return count;
}