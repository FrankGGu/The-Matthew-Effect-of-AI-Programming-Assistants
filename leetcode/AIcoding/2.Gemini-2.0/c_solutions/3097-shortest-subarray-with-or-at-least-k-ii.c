#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestSubarray(int* nums, int numsSize, int k) {
    int n = numsSize;
    int len = n + 1;
    int l = 0, r = 0, or_val = 0;
    while (r < n) {
        or_val |= nums[r];
        while (or_val >= k) {
            len = fmin(len, r - l + 1);
            or_val ^= nums[l] & or_val;
            l++;
        }
        r++;
    }
    return len == n + 1 ? -1 : len;
}