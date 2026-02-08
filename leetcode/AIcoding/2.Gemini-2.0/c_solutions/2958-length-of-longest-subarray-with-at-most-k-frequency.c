#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubarray(int* nums, int numsSize, int k) {
    int* freq = (int*)malloc(sizeof(int) * 200001);
    for (int i = 0; i <= 200000; i++) {
        freq[i] = 0;
    }
    int left = 0;
    int maxLen = 0;
    int count = 0;
    for (int right = 0; right < numsSize; right++) {
        int num = nums[right] + 100000;
        freq[num]++;
        if (freq[num] > k) {
            while (freq[num] > k) {
                int leftNum = nums[left] + 100000;
                freq[leftNum]--;
                left++;
            }
        }
        maxLen = (right - left + 1) > maxLen ? (right - left + 1) : maxLen;
    }
    free(freq);
    return maxLen;
}