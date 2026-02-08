#include <math.h>

long long llabs(long long x) {
    return x < 0 ? -x : x;
}

int minElements(int* nums, int numsSize, int limit, int goal) {
    long long currentSum = 0;
    for (int i = 0; i < numsSize; i++) {
        currentSum += nums[i];
    }

    long long diff = llabs(goal - currentSum);

    return (int)((diff + limit - 1) / limit);
}