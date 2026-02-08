#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countHillValley(int* nums, int numsSize){
    if (numsSize < 3) {
        return 0;
    }

    int count = 0;
    int prev = nums[0];
    for (int i = 1; i < numsSize - 1; i++) {
        if (nums[i] == prev) {
            continue;
        }
        int next_index = i + 1;
        while (next_index < numsSize && nums[next_index] == nums[i]) {
            next_index++;
        }
        if (next_index == numsSize)
        {
            break;
        }

        if ((nums[i] > prev && nums[i] > nums[next_index]) || (nums[i] < prev && nums[i] < nums[next_index])) {
            count++;
        }
        prev = nums[i];
    }

    return count;
}