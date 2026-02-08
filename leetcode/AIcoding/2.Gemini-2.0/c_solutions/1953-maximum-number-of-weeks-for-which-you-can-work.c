#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long maxNumberOfWeeks(int* milestones, int milestonesSize) {
    long long sum = 0;
    int max_val = 0;
    for (int i = 0; i < milestonesSize; i++) {
        sum += milestones[i];
        max_val = max(max_val, milestones[i]);
    }

    if (max_val > sum - max_val) {
        return 2LL * (sum - max_val) + 1;
    } else {
        return sum;
    }
}