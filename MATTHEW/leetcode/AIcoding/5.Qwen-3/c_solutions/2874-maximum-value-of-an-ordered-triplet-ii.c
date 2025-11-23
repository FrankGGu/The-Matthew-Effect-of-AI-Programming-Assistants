#include <stdio.h>
#include <stdlib.h>

int maximumTripletValue(int* nums, int numsSize) {
    int maxVal = 0;
    int n = numsSize;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (nums[i] > nums[j]) {
                for (int k = j + 1; k < n; k++) {
                    if (nums[j] < nums[k]) {
                        int current = nums[i] - nums[j] - nums[k];
                        if (current > maxVal) {
                            maxVal = current;
                        }
                    }
                }
            }
        }
    }
    return maxVal;
}