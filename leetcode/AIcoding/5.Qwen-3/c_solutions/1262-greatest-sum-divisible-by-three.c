#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int* dp;

int solve(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int remainder = sum % 3;
    if (remainder == 0) {
        return (int*)malloc(sizeof(int));
    }

    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }

    qsort(temp, numsSize, sizeof(int), compare);

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (temp[i] % 3 == remainder) {
            count++;
            if (count == 1) {
                break;
            }
        }
    }

    if (count == 0) {
        count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (temp[i] % 3 == (3 - remainder) % 3) {
                count++;
                if (count == 2) {
                    break;
                }
            }
        }

        if (count != 2) {
            return (int*)malloc(sizeof(int));
        }
    }

    int total = sum;
    if (count == 1) {
        for (int i = 0; i < numsSize; i++) {
            if (temp[i] % 3 == remainder) {
                total -= temp[i];
                break;
            }
        }
    } else {
        int idx1 = -1, idx2 = -1;
        for (int i = 0; i < numsSize; i++) {
            if (temp[i] % 3 == (3 - remainder) % 3) {
                if (idx1 == -1) {
                    idx1 = i;
                } else {
                    idx2 = i;
                    break;
                }
            }
        }
        total -= temp[idx1] + temp[idx2];
    }

    int* result = (int*)malloc(sizeof(int));
    *result = total;
    free(temp);
    return result;
}

int* largestSumDivisibleByThree(int* nums, int numsSize, int* returnSize) {
    int* result = solve(nums, numsSize);
    *returnSize = 1;
    return result;
}