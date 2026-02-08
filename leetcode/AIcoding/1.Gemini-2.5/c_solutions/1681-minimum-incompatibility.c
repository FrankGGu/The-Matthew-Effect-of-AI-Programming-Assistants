#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>

#define INF 1000000000 // A sufficiently large number

int N_global;
int K_global;
int GroupSize_global;
int* Nums_global;
int* GroupIncompatibility_global;
int* DP_global;

void precompute_group_incompatibility() {
    GroupIncompatibility_global = (int*)malloc((1 << N_global) * sizeof(int));
    for (int i = 0; i < (1 << N_global); ++i) {
        GroupIncompatibility_global[i] = INF;
    }

    for (int mask = 1; mask < (1 << N_global); ++mask) {
        if (__builtin_popcount(mask) != GroupSize_global) {
            continue;
        }

        int current_elements_freq[17] = {0};
        int min_val = 17;
        int max_val = 0;
        bool is_unique = true;

        for (int j = 0; j < N_global; ++j) {
            if ((mask >> j) & 1) {
                int val = Nums_global[j];
                current_elements_freq[val]++;
                if (current_elements_freq[val] > 1) {
                    is_unique = false;
                    break;
                }
                if (val < min_val) min_val = val;
                if (val > max_val) max_val = val;
            }
        }

        if (is_unique) {
            GroupIncompatibility_global[mask] = max_val - min_val;
        }
    }
}

void find_group_combinations(int full_mask, int current_idx, int elements_to_pick, int current_group_submask) {
    if (elements_to_pick == 0) {
        if (GroupIncompatibility_global[current_group_submask] != INF) {
            int prev_mask = full_mask ^ current_group_submask;
            if (DP_global[prev_mask] != INF) {
                DP_global[full_mask] = fmin(DP_global[full_mask], DP_global[prev_mask] + GroupIncompatibility_global[current_group_submask]);
            }
        }
        return;
    }

    int available_count = 0;
    for (int i = current_idx; i < N_global; ++i) {
        if ((full_mask >> i) & 1) {
            available_count++;
        }
    }
    if (available_count < elements_to_pick) {
        return;
    }

    for (int i = current_idx; i < N_global; ++i) {
        if ((full_mask >> i) & 1) {
            find_group_combinations(full_mask, i + 1, elements_to_pick - 1, current_group_submask | (1 << i));
        }
    }
}

int minimumIncompatibility(int* nums, int numsSize, int k) {
    N_global = numsSize;
    K_global = k;
    GroupSize_global = numsSize / k;
    Nums_global = nums;

    precompute_group_incompatibility();

    DP_global = (int*)malloc((1 << N_global) * sizeof(int));
    for (int i = 0; i < (1 << N_global); ++i) {
        DP_global[i] = INF;
    }
    DP_global[0] = 0;

    for (int mask = 1; mask < (1 << N_global); ++mask) {
        if (__builtin_popcount(mask) % GroupSize_global != 0) {
            continue;
        }

        int first_set_bit_idx = __builtin_ctz(mask);

        find_group_combinations(mask, first_set_bit_idx + 1, GroupSize_global - 1, (1 << first_set_bit_idx));
    }

    int result = DP_global[(1 << N_global) - 1];

    free(GroupIncompatibility_global);
    free(DP_global);

    if (result == INF) {
        return -1;
    }
    return result;
}