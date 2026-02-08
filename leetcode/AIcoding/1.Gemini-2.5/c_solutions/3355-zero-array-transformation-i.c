#include <stdbool.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    bool seen[101];
    memset(seen, 0, sizeof(seen));

    int operations = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && !seen[nums[i]]) {
            seen[nums[i]] = true;
            operations++;
        }
    }

    return operations;
}