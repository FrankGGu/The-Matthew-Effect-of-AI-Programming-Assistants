#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countMaxOrSubsets(int* nums, int numsSize){
    int maxOr = 0;
    for (int i = 0; i < numsSize; i++) {
        maxOr |= nums[i];
    }

    int count = 0;
    int currentOr = 0;

    void backtrack(int index) {
        if (index == numsSize) {
            if (currentOr == maxOr) {
                count++;
            }
            return;
        }

        // Include nums[index]
        int tempOr = currentOr;
        currentOr |= nums[index];
        backtrack(index + 1);

        // Exclude nums[index]
        currentOr = tempOr;
        backtrack(index + 1);
    }

    backtrack(0);
    return count;
}