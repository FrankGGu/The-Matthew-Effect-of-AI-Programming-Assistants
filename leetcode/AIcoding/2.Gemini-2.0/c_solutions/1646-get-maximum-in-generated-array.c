#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getMaximumGenerated(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    int nums[n + 1];
    nums[0] = 0;
    nums[1] = 1;
    int max_val = 1;
    for (int i = 2; i <= n; i++) {
        if (i % 2 == 0) {
            nums[i] = nums[i / 2];
        } else {
            nums[i] = nums[i / 2] + nums[i / 2 + 1];
        }
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }
    return max_val;
}