#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findDuplicate(int* nums, int numsSize) {
    int slow = nums[0];
    int fast = nums[nums[0]];

    while (slow != fast) {
        slow = nums[slow];
        fast = nums[nums[fast]];
    }

    fast = 0;
    while (slow != fast) {
        slow = nums[slow];
        fast = nums[fast];
    }

    return slow;
}