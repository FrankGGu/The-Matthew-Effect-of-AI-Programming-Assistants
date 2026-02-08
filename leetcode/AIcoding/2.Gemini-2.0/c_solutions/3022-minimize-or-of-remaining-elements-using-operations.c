#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeXor(int nums[], int numsSize, int k) {
    int n = numsSize;
    int ans = (1 << 30) - 1;
    for (int i = 0; i < (1 << n); i++) {
        if (__builtin_popcount(i) == k) {
            int or_val = 0;
            for (int j = 0; j < n; j++) {
                if (!((i >> j) & 1)) {
                    or_val |= nums[j];
                }
            }
            ans = (ans < or_val) ? ans : or_val;
        }
    }
    return ans;
}