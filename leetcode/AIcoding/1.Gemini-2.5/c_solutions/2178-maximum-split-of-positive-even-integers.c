#include <stdlib.h>

long long* maximumEvenSplit(long long finalSum, int* returnSize) {
    if (finalSum % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    // Maximum possible number of elements (k) occurs when finalSum is large.
    // The sum of the first k even numbers is k*(k+1).
    // If finalSum = 10^10, then k*(k+1) approx 10^10, so k approx sqrt(10^10) = 10^5.
    // Allocate an array large enough to hold up to 100,000 elements.
    // A slightly larger size like 100001 or 100005 is safe.
    long long *result = (long long *)malloc(sizeof(long long) * 100005);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    long long current_even = 2;

    while (finalSum >= current_even) {
        // We try to add the smallest distinct even numbers (2, 4, 6, ...)
        // as long as the remaining finalSum is large enough to accommodate them.
        // A crucial optimization is to check if finalSum - current_even is
        // still large enough for the *next* distinct even number (current_even + 2).
        // If not, it means current_even is the last distinct number we can add,
        // and the remaining finalSum should be added to it to maximize the number of distinct elements.
        // However, the simpler approach of adding current_even and then handling
        // any leftover finalSum by adding it to the last element also works and is easier to implement.

        // If finalSum - current_even < current_even + 2, it means the remaining sum
        // (finalSum - current_even) is too small to be a new distinct element (current_even + 2)
        // and also distinct from current_even. In this case, we should add finalSum
        // to the last element already added.
        // This condition can be written as finalSum < 2 * current_even + 2.
        // Let's use this condition to decide if we should add current_even or combine finalSum.
        if (finalSum - current_even < current_even + 2) {
            // This means the remaining 'finalSum' cannot be split further into distinct
            // even numbers starting from 'current_even'.
            // So, 'finalSum' itself should be added to the last element.
            // This applies only if we have already added some elements.
            if (count > 0) {
                result[count - 1] += finalSum;
            } else {
                // If count is 0, it means finalSum itself is the only number.
                // This case happens for finalSum = 2 or 4.
                // For finalSum = 2: current_even = 2. finalSum - 2 < 2*2+2 (0 < 6). Add 2. result=[2].
                // For finalSum = 4: current_even = 2. finalSum - 2 < 2*2+2 (2 < 6). Add 4 to last element.
                // The simpler logic below handles this correctly.
                result[count++] = finalSum; // If finalSum is 2 or 4, it becomes the only element.
            }
            finalSum = 0; // All sum has been used.
            break; // Exit the loop
        }

        // Simpler logic: Greedily add current_even
        result[count++] = current_even;
        finalSum -= current_even;
        current_even += 2;
    }

    // After the loop, if finalSum is still greater than 0, it means it's a remainder
    // that couldn't form a new distinct even number. Add this remainder to the last element added.
    // This handles cases like finalSum = 28, where [2, 4, 6, 8] are added, and 8 remains.
    // The 8 is added to the last element (8), making it 16. Result: [2, 4, 6, 16].
    if (finalSum > 0) {
        // `count` will always be > 0 here if `finalSum > 0` because `finalSum` would have been
        // at least 2 to enter the loop and add an element.
        // The only exception is if finalSum was 0 initially, but constraints say 1 <= finalSum.
        result[count - 1] += finalSum;
    }

    *returnSize = count;
    return result;
}