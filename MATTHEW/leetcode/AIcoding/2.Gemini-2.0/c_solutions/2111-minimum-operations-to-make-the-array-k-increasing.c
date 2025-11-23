#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthOfLIS(int* nums, int numsSize) {
    int tail[numsSize];
    int len = 0;
    for (int i = 0; i < numsSize; i++) {
        int l = 0, r = len;
        while (l < r) {
            int mid = l + (r - l) / 2;
            if (tail[mid] < nums[i]) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        tail[l] = nums[i];
        if (l == len) {
            len++;
        }
    }
    return len;
}

int kIncreasing(int* arr, int arrSize, int k) {
    int ans = 0;
    for (int i = 0; i < k; i++) {
        int nums[arrSize];
        int numsSize = 0;
        for (int j = i; j < arrSize; j += k) {
            nums[numsSize++] = arr[j];
        }
        ans += numsSize - lengthOfLIS(nums, numsSize);
    }
    return ans;
}