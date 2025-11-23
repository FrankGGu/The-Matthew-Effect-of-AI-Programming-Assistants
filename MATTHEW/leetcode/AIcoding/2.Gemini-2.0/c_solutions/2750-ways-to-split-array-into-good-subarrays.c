#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfGoodSubarraySplits(int* nums, int numsSize){
    long long count = 0;
    long long ans = 1;
    int first = -1;
    int last = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (first == -1) {
                first = i;
            }
            last = i;
        }
    }
    if (first == -1) {
        return 0;
    }
    int prev = first;
    for (int i = first + 1; i <= last; i++) {
        if (nums[i] == 1) {
            ans = (ans * (i - prev)) % 1000000007;
            prev = i;
        }
    }
    return (int)ans;
}