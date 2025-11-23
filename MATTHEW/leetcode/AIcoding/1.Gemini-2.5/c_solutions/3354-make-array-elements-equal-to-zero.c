#include <stddef.h> // For size_t

int minimumOperations(int* nums, int numsSize) {
    int seen[101] = {0};
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            if (seen[nums[i]] == 0) {
                seen[nums[i]] = 1;
                count++;
            }
        }
    }
    return count;
}