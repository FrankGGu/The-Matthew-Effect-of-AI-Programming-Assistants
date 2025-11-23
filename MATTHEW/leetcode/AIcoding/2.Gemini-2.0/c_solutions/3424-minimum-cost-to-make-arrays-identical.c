#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minCost(int* nums, int numsSize, int* cost, int costSize) {
    int* combined = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        combined[i] = nums[i];
    }
    qsort(combined, numsSize, sizeof(int), compare);

    int median;
    if (numsSize % 2 == 0) {
        median = (combined[numsSize / 2 - 1] + combined[numsSize / 2]) / 2;
    } else {
        median = combined[numsSize / 2];
    }

    long long min_cost = LLONG_MAX;

    for (int m = 0; m < numsSize; m++) {
        long long current_cost = 0;
        for (int i = 0; i < numsSize; i++) {
            current_cost += (long long)abs(nums[i] - combined[m]) * cost[i];
        }
        if (current_cost < min_cost) {
            min_cost = current_cost;
        }
    }

    for(int m = 0; m < numsSize - 1; ++m){
        if(combined[m] != combined[m+1]){
            int mid = (combined[m] + combined[m+1]) / 2;
            long long current_cost = 0;
            for (int i = 0; i < numsSize; i++) {
                current_cost += (long long)abs(nums[i] - mid) * cost[i];
            }
            if (current_cost < min_cost) {
                min_cost = current_cost;
            }
        }
    }

    long long current_cost = 0;
        for (int i = 0; i < numsSize; i++) {
            current_cost += (long long)abs(nums[i] - combined[0]) * cost[i];
        }
        if (current_cost < min_cost) {
            min_cost = current_cost;
        }

    current_cost = 0;
        for (int i = 0; i < numsSize; i++) {
            current_cost += (long long)abs(nums[i] - combined[numsSize-1]) * cost[i];
        }
        if (current_cost < min_cost) {
            min_cost = current_cost;
        }

    free(combined);
    return min_cost;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}