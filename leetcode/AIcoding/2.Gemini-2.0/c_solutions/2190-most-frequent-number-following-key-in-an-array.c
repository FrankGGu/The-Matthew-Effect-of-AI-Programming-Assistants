#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mostFrequent(int* nums, int numsSize, int key) {
    int count[1001] = {0};
    int max_freq = 0;
    int most_frequent_target = -1;

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == key) {
            count[nums[i + 1]]++;
            if (count[nums[i + 1]] > max_freq) {
                max_freq = count[nums[i + 1]];
                most_frequent_target = nums[i + 1];
            }
        }
    }

    return most_frequent_target;
}