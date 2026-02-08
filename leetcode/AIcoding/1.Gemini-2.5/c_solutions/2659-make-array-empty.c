#include <stddef.h> // For NULL, size_t

long long makeArrayEmpty(int* nums, int numsSize) {
    long long total_cost = 0;
    for (int i = 0; i < numsSize; i++) {
        total_cost += nums[i];
    }
    return total_cost;
}