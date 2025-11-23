#include <stdlib.h>

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int compareLongLong(const void* a, const void* b) {
    long long valA = *(long long*)a;
    long long valB = *(long long*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

long long minCostToRemoveElements(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compareInt);

    long long* distinct_removal_costs = (long long*)malloc(numsSize * sizeof(long long));

    int distinct_count = 0;
    int current_val = nums[0];
    int current_freq = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == current_val) {
            current_freq++;
        } else {
            distinct_removal_costs[distinct_count++] = (long long)current_val * current_freq;
            current_val = nums[i];
            current_freq = 1;
        }
    }
    distinct_removal_costs[distinct_count++] = (long long)current_val * current_freq;

    if (distinct_count <= k) {
        free(distinct_removal_costs);
        return 0;
    }

    qsort(distinct_removal_costs, distinct_count, sizeof(long long), compareLongLong);

    long long total_min_cost = 0;
    int removals_needed = distinct_count - k;
    for (int i = 0; i < removals_needed; ++i) {
        total_min_cost += distinct_removal_costs[i];
    }

    free(distinct_removal_costs);
    return total_min_cost;
}