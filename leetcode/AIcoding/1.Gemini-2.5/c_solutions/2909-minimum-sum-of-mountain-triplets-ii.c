#include <limits.h>
#include <stdlib.h>

static int min(int a, int b) {
    return a < b ? a : b;
}

int minimumSum(int* nums, int numsSize) {
    if (numsSize < 3) {
        return -1;
    }

    int* minLeft = (int*)malloc(numsSize * sizeof(int));
    int* minRight = (int*)malloc(numsSize * sizeof(int));

    minLeft[0] = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        minLeft[i] = min(minLeft[i - 1], nums[i - 1]);
    }

    minRight[numsSize - 1] = INT_MAX;
    for (int i = numsSize - 2; i >= 0; i--) {
        minRight[i] = min(minRight[i + 1], nums[i + 1]);
    }

    long long minTripletSum = LLONG_MAX;

    for (int j = 1; j < numsSize - 1; j++) {
        int leftVal = minLeft[j];
        int rightVal = minRight[j];

        if (leftVal < nums[j] && rightVal < nums[j]) {
            long long currentSum = (long long)leftVal + nums[j] + rightVal;
            if (currentSum < minTripletSum) {
                minTripletSum = currentSum;
            }
        }
    }

    free(minLeft);
    free(minRight);

    if (minTripletSum == LLONG_MAX) {
        return -1;
    } else {
        return (int)minTripletSum;
    }
}