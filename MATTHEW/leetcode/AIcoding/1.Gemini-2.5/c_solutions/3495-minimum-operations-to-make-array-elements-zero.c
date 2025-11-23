#include <stdbool.h>

int minimumOperations(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    bool seen[101] = {false}; 

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > 0) {
            seen[nums[i]] = true;
        }
    }

    int operations = 0;
    for (int i = 1; i <= 100; ++i) {
        if (seen[i]) {
            operations++;
        }
    }

    return operations;
}