#include <stdlib.h> 

long long beautifulSubarrays(int* nums, int numsSize, int k) {
    int* freq = (int*) calloc(numsSize + 1, sizeof(int));

    freq[0] = 1;

    long long count = 0;
    int odd_count = 0; 

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 != 0) {
            odd_count++;
        }

        if (odd_count >= k) {
            count += freq[odd_count - k];
        }

        freq[odd_count]++;
    }

    free(freq);

    return count;
}