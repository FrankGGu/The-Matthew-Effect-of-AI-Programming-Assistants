#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int sumDistance(int* nums, int numsSize, char* s, int sSize) {
    int* moved = (int*)malloc(sizeof(int) * numsSize);
    int movedSize = 0;

    for (int i = 0; i < numsSize; i++) {
        if (s[i] == 'L') {
            moved[i] = nums[i] - 1;
        } else if (s[i] == 'R') {
            moved[i] = nums[i] + 1;
        } else {
            moved[i] = nums[i];
        }
    }

    qsort(moved, numsSize, sizeof(int), cmpfunc);

    long long sum = 0;
    long long mod = 1000000007;

    for (int i = 1; i < numsSize; i++) {
        sum = (sum + (long long)(moved[i] - moved[i - 1]) * i % mod * (numsSize - i) % mod) % mod;
    }

    free(moved);

    return (int)sum;
}