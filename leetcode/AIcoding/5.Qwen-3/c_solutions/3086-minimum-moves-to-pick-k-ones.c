#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minMoves(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int result = INT_MAX;
    int left = 0;
    int right = 0;

    while (right < n) {
        if (nums[right] == 1) {
            if (right - left + 1 == k) {
                int total = prefix[right + 1] - prefix[left];
                int mid = left + (right - left) / 2;
                int moves = 0;
                for (int i = left; i <= right; ++i) {
                    moves += abs(i - mid);
                }
                result = (result < moves) ? result : moves;
                left++;
            } else if (right - left + 1 > k) {
                left++;
            }
        }
        right++;
    }

    free(prefix);
    return result;
}