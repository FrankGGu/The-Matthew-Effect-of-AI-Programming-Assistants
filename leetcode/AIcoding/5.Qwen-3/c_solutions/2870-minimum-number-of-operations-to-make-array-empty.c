#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int operations = 0;
    for (int i = 0; i <= 100000; i++) {
        if (count[i] == 0) continue;
        if (count[i] % 3 == 0) {
            operations += count[i] / 3;
        } else if (count[i] % 3 == 1) {
            if (count[i] == 1) return -1;
            operations += (count[i] - 4) / 3 + 2;
        } else {
            operations += count[i] / 3 + 1;
        }
    }
    return operations;
}