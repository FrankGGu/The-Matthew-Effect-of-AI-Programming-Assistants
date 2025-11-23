#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool circularArrayLoop(int* nums, int numsSize) {
    if (numsSize <= 1) return false;

    for (int i = 0; i < numsSize; i++) {
        int slow = i, fast = i;
        bool direction = nums[i] > 0;

        while (true) {
            slow = ((slow + nums[slow]) % numsSize + numsSize) % numsSize;
            if (direction != (nums[slow] > 0)) break;

            fast = ((fast + nums[fast]) % numsSize + numsSize) % numsSize;
            if (direction != (nums[fast] > 0)) break;

            fast = ((fast + nums[fast]) % numsSize + numsSize) % numsSize;
            if (direction != (nums[fast] > 0)) break;

            if (slow == fast) {
                if (slow == ((slow + nums[slow]) % numsSize + numsSize) % numsSize) break;
                return true;
            }
        }
    }

    return false;
}