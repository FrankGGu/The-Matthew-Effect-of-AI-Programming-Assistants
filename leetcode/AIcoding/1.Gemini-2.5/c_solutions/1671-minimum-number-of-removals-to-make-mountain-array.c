#include <stdlib.h> 

int max(int a, int b) {
    return a > b ? a : b;
}

int minimumMountainRemovals(int* nums, int numsSize) {
    if (numsSize < 3) {
        return numsSize;
    }

    int n = numsSize;
    int* lis = (int*)malloc(n * sizeof(int));
    int* lds = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; ++i) {
        lis[i] = 1;
        for (int j = 0; j < i; ++j) {
            if (nums[i] > nums[j]) {
                lis[i] = max(lis[i], lis[j] + 1);
            }
        }
    }

    for (int i = n - 1; i >= 0; --i) {
        lds[i] = 1;
        for (int j = n - 1; j > i; --j) {
            if (nums[i] > nums[j]) {
                lds[i] = max(lds[i], lds[j] + 1);
            }
        }
    }

    int max_mountain_length = 0;

    for (int i = 0; i < n; ++i) {
        if (lis[i] > 1 && lds[i] > 1) {
            max_mountain_length = max(max_mountain_length, lis[i] + lds[i] - 1);
        }
    }

    free(lis);
    free(lds);

    if (max_mountain_length == 0) {
        return n;
    }

    return n - max_mountain_length;
}