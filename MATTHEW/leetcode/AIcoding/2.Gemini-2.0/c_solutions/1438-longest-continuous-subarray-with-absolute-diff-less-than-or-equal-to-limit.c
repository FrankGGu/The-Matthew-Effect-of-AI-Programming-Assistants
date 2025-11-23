#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubarray(int* nums, int numsSize, int limit) {
    int max_len = 0;
    int min_queue[numsSize], max_queue[numsSize];
    int min_head = 0, min_tail = 0;
    int max_head = 0, max_tail = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        while (min_head < min_tail && nums[min_queue[min_tail - 1]] >= nums[right]) {
            min_tail--;
        }
        min_queue[min_tail++] = right;

        while (max_head < max_tail && nums[max_queue[max_tail - 1]] <= nums[right]) {
            max_tail--;
        }
        max_queue[max_tail++] = right;

        while (nums[max_queue[max_head]] - nums[min_queue[min_head]] > limit) {
            if (max_queue[max_head] == left) {
                max_head++;
            }
            if (min_queue[min_head] == left) {
                min_head++;
            }
            left++;
        }
        max_len = (right - left + 1) > max_len ? (right - left + 1) : max_len;
    }
    return max_len;
}