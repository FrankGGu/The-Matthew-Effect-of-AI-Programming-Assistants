#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countGood(int* nums, int numsSize, int k) {
    long long count = 0;
    int left = 0;
    int pairs = 0;
    int freq[100001] = {0};

    for (int right = 0; right < numsSize; right++) {
        pairs -= freq[nums[right]] * (freq[nums[right]] - 1) / 2;
        freq[nums[right]]++;
        pairs += freq[nums[right]] * (freq[nums[right]] - 1) / 2;

        while (pairs >= k) {
            count += numsSize - right;
            pairs -= freq[nums[left]] * (freq[nums[left]] - 1) / 2;
            freq[nums[left]]--;
            pairs += freq[nums[left]] * (freq[nums[left]] - 1) / 2;
            left++;
        }
    }

    return count;
}