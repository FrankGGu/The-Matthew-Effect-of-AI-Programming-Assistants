#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(int* nums, int numsSize) {
    int n = numsSize;
    int count[32] = {0};
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 32; j++) {
            if (nums[i] & (1 << j)) {
                count[j]++;
            }
        }
    }
    int res = 0;
    for (int j = 0; j < 32; j++) {
        if (count[j] % 2 == 1) {
            res++;
        }
    }
    return res;
}