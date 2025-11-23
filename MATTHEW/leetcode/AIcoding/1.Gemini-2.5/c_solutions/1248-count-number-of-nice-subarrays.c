#include <stdlib.h>

int numberOfSubarrays(int* nums, int numsSize, int k) {
    int* counts = (int*)calloc(numsSize + 1, sizeof(int));
    if (counts == NULL) {
        return 0;
    }

    counts[0] = 1;
    int current_odd_count = 0;
    long long nice_subarrays = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 != 0) {
            current_odd_count++;
        }

        if (current_odd_count >= k) {
            nice_subarrays += counts[current_odd_count - k];
        }

        counts[current_odd_count]++;
    }

    free(counts);
    return (int)nice_subarrays;
}