#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeMax(int* nums, int numsSize, int p) {
    if (p == 0) return 0;

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *,const void *))cmpfunc);

    int left = 0, right = nums[numsSize - 1] - nums[0];
    int ans = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0;
        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i+1] - nums[i] <= mid) {
                count++;
                i++;
            }
        }

        if (count >= p) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}