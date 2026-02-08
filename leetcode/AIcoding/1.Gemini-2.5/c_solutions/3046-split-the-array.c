#include <stdbool.h>
#include <string.h>

bool splitArray(int* nums, int numsSize) {
    int freq[1001];
    memset(freq, 0, sizeof(freq));

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 1; i <= 1000; i++) {
        if (freq[i] % 2 != 0) {
            return false;
        }
    }

    return true;
}