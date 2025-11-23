#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long countFairPairs(int* nums, int numsSize, int lower, int upper){
    qsort(nums, numsSize, sizeof(int), compare);
    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        int low = lower - nums[i];
        int up = upper - nums[i];

        int left = 0, right = numsSize - 1;
        int lowerIndex = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] >= low) {
                lowerIndex = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = 0, right = numsSize - 1;
        int upperIndex = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] <= up) {
                upperIndex = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (lowerIndex != -1 && upperIndex != -1 && lowerIndex <= upperIndex) {
            for(int j = lowerIndex; j <= upperIndex; j++){
                if(j > i){
                    count++;
                }
            }
        }
    }
    return count;
}