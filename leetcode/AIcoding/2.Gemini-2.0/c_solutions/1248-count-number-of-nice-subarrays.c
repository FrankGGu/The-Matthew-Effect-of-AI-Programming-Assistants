#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSubarrays(int* nums, int numsSize, int k){
    int count = 0;
    int odd_count = 0;
    int left = 0;
    int right = 0;
    int ans = 0;

    while (right < numsSize) {
        if (nums[right] % 2 != 0) {
            odd_count++;
        }

        while (odd_count == k) {
            int temp = 0;
            while (left < numsSize && nums[left] % 2 == 0) {
                temp++;
                left++;
            }
            ans += (temp + 1);

            odd_count--;
            left++;
        }
        right++;
    }

    return ans;
}