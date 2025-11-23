#include <stdlib.h>

long long countGoodSubarrays(int* nums, int numsSize, int k) {
    if (k == 0) {
        return (long long)numsSize * (numsSize + 1) / 2;
    }

    long long ans = 0;
    int left = 0;
    long long current_pairs = 0;

    int* freq = (int*)calloc(200001, sizeof(int)); 

    for (int right = 0; right < numsSize; right++) {
        current_pairs += freq[nums[right]];
        freq[nums[right]]++;

        while (current_pairs >= k) {
            ans += (numsSize - right);

            freq[nums[left]]--;
            current_pairs -= freq[nums[left]];
            left++;
        }
    }

    free(freq);
    return ans;
}