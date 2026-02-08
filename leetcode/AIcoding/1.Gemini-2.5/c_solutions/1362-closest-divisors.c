#include <stdlib.h>
#include <math.h>
#include <limits.h>

int* closestDivisors(int num, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);

    long long target1 = (long long)num + 1;
    long long target2 = (long long)num + 2;

    long long minDiff = LLONG_MAX;

    // Check target1
    long long sqrt_target1 = (long long)sqrt(target1);
    for (long long i = sqrt_target1; i >= 1; --i) {
        if (target1 % i == 0) {
            long long j = target1 / i;
            if (llabs(i - j) < minDiff) {
                minDiff = llabs(i - j);
                result[0] = (int)i;
                result[1] = (int)j;
            }
            // For a given target, the pair (i, target/i) closest to sqrt(target)
            // will have the minimum difference. Since we iterate downwards from sqrt(target),
            // the first pair found will be the closest for this target.
            break;
        }
    }

    // Check target2
    long long sqrt_target2 = (long long)sqrt(target2);
    for (long long i = sqrt_target2; i >= 1; --i) {
        if (target2 % i == 0) {
            long long j = target2 / i;
            if (llabs(i - j) < minDiff) {
                minDiff = llabs(i - j);
                result[0] = (int)i;
                result[1] = (int)j;
            }
            // Same logic as for target1, break after finding the first pair for target2.
            break;
        }
    }

    return result;
}