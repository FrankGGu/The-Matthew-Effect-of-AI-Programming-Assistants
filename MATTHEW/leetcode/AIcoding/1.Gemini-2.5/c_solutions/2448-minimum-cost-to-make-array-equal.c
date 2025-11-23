#include <stdlib.h> // For malloc, qsort, abs

typedef struct {
    int num;
    int cost;
} Pair;

int comparePairs(const void* a, const void* b) {
    return ((Pair*)a)->num - ((Pair*)b)->num;
}

long long minCost(int* nums, int numsSize, int* cost) {
    Pair* pairs = (Pair*)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        pairs[i].num = nums[i];
        pairs[i].cost = cost[i];
    }

    qsort(pairs, numsSize, sizeof(Pair), comparePairs);

    long long total_cost_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        total_cost_sum += pairs[i].cost;
    }

    long long current_cost_sum = 0;
    int target_val = 0;
    for (int i = 0; i < numsSize; i++) {
        current_cost_sum += pairs[i].cost;
        if (current_cost_sum * 2 >= total_cost_sum) {
            target_val = pairs[i].num;
            break;
        }
    }

    long long final_min_cost = 0;
    for (int i = 0; i < numsSize; i++) {
        final_min_cost += (long long)pairs[i].cost * abs(pairs[i].num - target_val);
    }

    free(pairs);

    return final_min_cost;
}