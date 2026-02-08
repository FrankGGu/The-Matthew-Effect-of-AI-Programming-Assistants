#include <stdlib.h>
#include <math.h> // For abs, though integer abs is in stdlib.h

typedef struct {
    int num;
    int cst;
} Pair;

int comparePairs(const void *a, const void *b) {
    Pair *pa = (Pair *)a;
    Pair *pb = (Pair *)b;
    return pa->num - pb->num;
}

long long minCost(int* nums, int numsSize, int* cost) {
    // Create an array of Pair structs
    Pair *pairs = (Pair *)malloc(numsSize * sizeof(Pair));
    if (pairs == NULL) {
        // Handle allocation failure, though LeetCode usually guarantees success
        return -1; // Or appropriate error handling
    }

    // Populate the pairs array
    for (int i = 0; i < numsSize; i++) {
        pairs[i].num = nums[i];
        pairs[i].cst = cost[i];
    }

    // Sort the pairs array based on the 'num' values
    qsort(pairs, numsSize, sizeof(Pair), comparePairs);

    // Calculate the total sum of costs
    long long totalCostSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalCostSum += pairs[i].cst;
    }

    // Find the weighted median
    // The weighted median is the point 'x' that minimizes sum(abs(num[i] - x) * cost[i])
    // It's the first num[i] such that the sum of costs to its left (including itself)
    // is greater than or equal to half of the total cost sum.
    long long currentCostSum = 0;
    long long x_median = 0;
    for (int i = 0; i < numsSize; i++) {
        currentCostSum += pairs[i].cst;
        if (currentCostSum * 2 >= totalCostSum) {
            x_median = pairs[i].num;
            break;
        }
    }

    // Calculate the minimum total cost using the found x_median
    long long minTotalCost = 0;
    for (int i = 0; i < numsSize; i++) {
        minTotalCost += (long long)abs(pairs[i].num - x_median) * pairs[i].cst;
    }

    // Free the allocated memory
    free(pairs);

    return minTotalCost;
}