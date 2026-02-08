#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long maxKelements(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), compare);

    long long score = 0;
    for(int i = 0; i < k; i++){
        score += nums[0];
        nums[0] = (nums[0] + 2) / 3;
        qsort(nums, numsSize, sizeof(int), compare);
    }

    return score;
}