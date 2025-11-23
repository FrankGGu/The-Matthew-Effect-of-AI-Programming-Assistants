#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maximumDifferenceBetweenEvenAndOddFrequencyII(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int first_val = (nums[0] % 2 == 0) ? 1 : -1;

    int max_so_far = first_val;
    int current_max = first_val;

    int min_so_far = first_val;
    int current_min = first_val;

    for (int i = 1; i < numsSize; ++i) {
        int val = (nums[i] % 2 == 0) ? 1 : -1;

        current_max = max(val, current_max + val);
        max_so_far = max(max_so_far, current_max);

        current_min = min(val, current_min + val);
        min_so_far = min(min_so_far, current_min);
    }

    return max(abs(max_so_far), abs(min_so_far));
}