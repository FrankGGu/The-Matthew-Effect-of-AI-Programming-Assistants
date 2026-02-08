#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int size;
} MajorityChecker;

MajorityChecker* majorityCheckerCreate(int* arr, int arrSize) {
    MajorityChecker* checker = (MajorityChecker*)malloc(sizeof(MajorityChecker));
    checker->nums = arr;
    checker->size = arrSize;
    return checker;
}

int majorityCheckerQuery(MajorityChecker* checker, int left, int right, int threshold) {
    int count = 0, majority = -1;
    for (int i = left; i <= right; i++) {
        if (count == 0) {
            majority = checker->nums[i];
            count = 1;
        } else if (checker->nums[i] == majority) {
            count++;
        } else {
            count--;
        }
    }

    count = 0;
    for (int i = left; i <= right; i++) {
        if (checker->nums[i] == majority) {
            count++;
        }
    }

    return count >= threshold ? majority : -1;
}

void majorityCheckerFree(MajorityChecker* checker) {
    free(checker);
}