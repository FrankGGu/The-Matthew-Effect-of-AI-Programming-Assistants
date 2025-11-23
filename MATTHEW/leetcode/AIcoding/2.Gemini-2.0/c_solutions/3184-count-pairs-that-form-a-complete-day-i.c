#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int distinct_count = 0;
            int distinct_nums[101] = {0};
            for (int k = i; k <= j; k++) {
                if (distinct_nums[nums[k]] == 0) {
                    distinct_count++;
                    distinct_nums[nums[k]] = 1;
                }
            }

            int total_distinct = 0;
            int total_distinct_nums[101] = {0};
            for (int k = 0; k < numsSize; k++) {
                if (total_distinct_nums[nums[k]] == 0) {
                    total_distinct++;
                    total_distinct_nums[nums[k]] = 1;
                }
            }

            if (distinct_count == total_distinct) {
                count++;
            }
        }
    }
    return count;
}