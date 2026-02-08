#include <vector>
#include <utility> // For std::pair

class Solution {
public:
    // Helper for modular exponentiation
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1e9 + 7;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    // This function assumes the following problem structure based on the title:
    // - `nums`: The initial array of integers.
    // - `k`: The total number of multiplication operations to perform.
    // - `operations`: A list of (index, multiplier) pairs. These operations form a cycle
    //   that is repeated `k` times in total.
    // - All calculations should be performed modulo 10^9 + 7.
    // - The function returns the final state of the `nums` array.
    std::vector<int> finalArrayState(std::vector<int>& nums, long long k, const std::vector<std::pair<int, int>>& operations) {
        long long MOD = 1e9 + 7;
        int n = nums.size();

        if (k == 0) {
            return nums;
        }

        int p = operations.size();
        if (p == 0) {
            return nums; // No operations defined, array remains unchanged
        }

        // per_element_total_multiplier_in_one_cycle[i] stores the total multiplier for nums[i]
        // after one full cycle of `p` operations.
        std::vector<long long> per_element_total_multiplier_in_one_cycle(n, 1);

        // per_element_num_multiplications_in_one_cycle[i] stores how many times nums[i]
        // is targeted by an operation within one full cycle. This is used to check
        // if nums[i] is affected by the cycle at all.
        std::vector<long long> per_element_num_multiplications_in_one_cycle(n, 0);

        // Calculate the total multiplier and number of times each element is multiplied
        // within one full cycle of `p` operations.
        for (int j = 0; j < p; ++j) {
            int idx = operations[j].first;
            int val = operations[j].second;
            per_element_total_multiplier_in_one_cycle[idx] = (per_element_total_multiplier_in_one_cycle[idx] * val) % MOD;
            per_element_num_multiplications_in_one_cycle[idx]++;
        }

        long long num_full_cycles = k / p;
        long long remaining_ops_count = k % p;

        // Apply multipliers from the full cycles
        for (int i = 0; i < n; ++i) {
            long long total_multiplier_for_i_from_full_cycles = 1;
            if (per_element_num_multiplications_in_one_cycle[i] > 0) {
                long long full_cycle_multiplier = per_element_total_multiplier_in_one_cycle[i];
                total_multiplier_for_i_from_full_cycles = power(full_cycle_multiplier, num_full_cycles);
            }
            nums[i] = (1LL * nums[i] * total_multiplier_for_i_from_full_cycles) % MOD;
        }

        // Apply multipliers from the remaining operations (partial cycle)
        for (int j = 0; j < remaining_ops_count; ++j) {
            int idx = operations[j].first;
            int val = operations[j].second;
            nums[idx] = (1LL * nums[idx] * val) % MOD;
        }

        return nums;
    }
};