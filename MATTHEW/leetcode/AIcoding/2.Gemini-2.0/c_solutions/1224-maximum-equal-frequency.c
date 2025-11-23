#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxEqualFreq(int* nums, int numsSize) {
    int freq[100001] = {0};
    int count[100001] = {0};
    int max_freq = 0;
    int ans = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (freq[num] > 0) {
            count[freq[num]]--;
        }
        freq[num]++;
        count[freq[num]]++;
        max_freq = (freq[num] > max_freq) ? freq[num] : max_freq;

        if (max_freq == 1) {
            ans = i + 1;
        } else if (count[max_freq] * max_freq + count[max_freq - 1] * (max_freq - 1) == i + 1 && count[max_freq] == 1) {
            ans = i + 1;
        } else if (count[1] == 1 && count[max_freq] * max_freq + 1 == i + 1) {
            ans = i + 1;
        } else if (count[max_freq] == 1 && count[max_freq] * max_freq + count[max_freq - 1] * (max_freq - 1) == i + 1) {
            ans = i + 1;
        } else if(count[max_freq] == i+1) {
             ans = i+1;
        }

    }
    return ans;
}