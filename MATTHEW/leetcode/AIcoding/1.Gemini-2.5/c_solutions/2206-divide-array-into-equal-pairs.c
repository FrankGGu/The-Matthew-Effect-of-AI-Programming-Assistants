#include <stdbool.h>
#include <string.h> // Required for memset

bool canConstruct(int* nums, int numsSize) {
    int counts[1001];
    memset(counts, 0, sizeof(counts));

    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
    }

    for (int i = 0; i <= 1000; i++) {
        if (counts[i] % 2 != 0) {
            return false;
        }
    }

    return true;
}