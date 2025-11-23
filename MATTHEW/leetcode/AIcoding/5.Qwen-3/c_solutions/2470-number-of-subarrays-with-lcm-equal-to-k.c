#include <stdio.h>
#include <stdlib.h>

int numSubarrayLCM(int target, int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_lcm = nums[i];
        if (current_lcm == target) count++;
        for (int j = i + 1; j < numsSize; j++) {
            int a = nums[j], b = current_lcm;
            while (a && b) {
                if (a > b) a %= b;
                else b %= a;
            }
            current_lcm = (nums[j] * current_lcm) / (a + b);
            if (current_lcm == target) count++;
            else if (current_lcm > target) break;
        }
    }
    return count;
}