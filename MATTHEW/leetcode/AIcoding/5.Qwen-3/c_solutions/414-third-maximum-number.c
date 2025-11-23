#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

long long thirdMax(int* nums, int numsSize) {
    long long first = LLONG_MIN;
    long long second = LLONG_MIN;
    long long third = LLONG_MIN;

    for (int i = 0; i < numsSize; i++) {
        long long num = nums[i];
        if (num == first || num == second || num == third) continue;
        if (num > first) {
            third = second;
            second = first;
            first = num;
        } else if (num > second) {
            third = second;
            second = num;
        } else if (num > third) {
            third = num;
        }
    }

    return third == LLONG_MIN ? first : third;
}