#include <stdlib.h> // Required for abs

int getMinDistance(int* nums, int numsSize, int target, int start) {
    int min_dist = numsSize; // Maximum possible distance

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            int current_dist = abs(i - start);
            if (current_dist < min_dist) {
                min_dist = current_dist;
            }
        }
    }
    return min_dist;
}