#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findShortestSubArray(int* nums, int numsSize) {
    int first[50000] = {0};
    int last[50000] = {0};
    int count[50000] = {0};
    int degree = 0;

    for (int i = 0; i < numsSize; i++) {
        if (first[nums[i]] == 0) {
            first[nums[i]] = i + 1;
        }
        last[nums[i]] = i + 1;
        count[nums[i]]++;
        if (count[nums[i]] > degree) {
            degree = count[nums[i]];
        }
    }

    int shortest = numsSize;
    for (int i = 0; i < 50000; i++) {
        if (count[i] == degree) {
            if (last[i] - first[i] + 1 < shortest && first[i] != 0) {
                shortest = last[i] - first[i] + 1;
            }
        }
    }

    return shortest;
}