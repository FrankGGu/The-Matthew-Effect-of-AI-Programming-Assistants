#include <stdbool.h>
#include <string.h>

int makeArrayZero(int* nums, int numsSize) {
    bool seen[101];
    memset(seen, false, sizeof(seen));

    int distinct_count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            if (!seen[nums[i]]) {
                seen[nums[i]] = true;
                distinct_count++;
            }
        }
    }
    return distinct_count;
}