#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath> // For std::floor and std::log2
#include <set>   // For permutation check, though vector<bool> is more efficient

class Solution {
public:
    std::vector<int> solve(int n, const std::vector<int>& and_vals, int p0_val) {
        std::vector<int> p_temp(n);
        p_temp[0] = p0_val;

        std::vector<int> fixed_X_vals(n);
        std::vector<int> free_X_masks(n); // Bits that can be flipped in X_i

        int current_X_xor_sum = 0;

        int max_bit_pos = 0;
        if (n > 1) {
            max_bit_pos = static_cast<int>(std::floor(std::log2(n - 1)));
        }

        // Store indices where free bits exist for each bit position k
        std::vector<std::vector<int>> free_vars_indices_by_bit(max_bit_pos + 1);

        for (int i = 0; i < n; ++i) {
            // Condition 1: p[i] must be a superset of A_i (i.e., p[i] & A_i == A_i)
            // If this is not true, then p0_val is invalid.
            if ((p_temp[i] & and_vals[i]) != and_vals[i]) {
                return {};
            }

            // Calculate the fixed part of X_i = p[i] ^ p[i+1]
            // X_i must be >= (p[i] & ~A_i) and X_i must be <= ~A_i
            // So, initially, we set X_i to its minimal value: p[i] & ~A_i
            fixed_X_vals[i] = p_temp[i] & (~and_vals[i]);
            current_X_xor_sum ^= fixed_X_vals[i];

            // Calculate the mask of free bits for X_i
            // These are bits k where p[i]_k = 0 and A_i_k = 0.
            // For such k, X_i_k can be 0 or 1.
            free_X_masks[i] = (~p_temp[i]) & (~and_vals[i]);
            for (int k = 0; k <= max_bit_pos; ++k) {
                if ((free_X_masks[i] >> k) & 1) {
                    free_vars_indices_by_bit[k].push_back(i);
                }
            }

            // Propagate p[i+1] based on minimal X_i (fixed_X_vals[i]) for the next iteration
            if (i < n - 1) {
                p_temp[i+1] = p_temp[i] ^ fixed_X_vals[i];
            }
        }

        // Now adjust X_i values using free_choice_mask_i to make total XOR sum 0
        // The total XOR sum of X_i values must be 0 (X_0 ^ X_1 ^ ... ^ X_{n-1} = 0)
        std::vector<int> final_X_vals = fixed_X_vals;
        for (int k = 0; k <= max_bit_pos; ++k) {
            if ((current_X_xor_sum >> k) & 1) { // If this bit needs to be flipped in the XOR sum
                if (free_vars_indices_by_bit[k].empty()) {
                    return {}; // Cannot satisfy XOR sum for this bit, no free variable to flip
                }
                // Pick one free variable to flip its k-th bit
                int idx_to_flip = free_vars_indices_by_bit[k][0];
                final_X_vals[idx_to_flip] ^= (1 << k);
            }
        }

        // Reconstruct final p values using the adjusted X_i values
        std::vector<int> final_p_values(n);
        final_p_values[0] = p0_val;
        for (int i = 0; i < n - 1; ++i) {
            final_p_values[i+1] = final_p_values[i] ^ final_X_vals[i];
        }

        // Final condition check: p[n-1] & p[0] must equal A_{n-1}
        if ((final_p_values[n-1] & final_p_values[0]) != and_vals[n-1]) {
            return {}; // Contradiction
        }

        // Check if final_p_values is a permutation of 0 to n-1
        // Use a boolean vector for efficient check
        std::vector<bool> seen(n, false);
        for (int val : final_p_values) {
            if (val < 0 || val >= n || seen[val]) {
                return {}; // Not a valid permutation (duplicate or out of range)
            }
            seen[val] = true;
        }

        return final_p_values;
    }

    std::vector<int> solveNANDPuzzle(int n, std::vector<int>& results) {
        std::vector<int> and_vals(n);
        for (int i = 0; i < n; ++i) {
            and_vals[i] = ~results[i]; // A_i = ~(results[i])
        }

        int xor_sum_0_to_n_minus_1 = 0;
        if (n > 0) {
            for (int i = 0; i < n; ++i) {
                xor_sum_0_to_n_minus_1 ^= i;
            }
        }

        // Try p[0] = 0 as the first candidate
        std::vector<int> solution = solve(n, and_vals, 0);
        if (!solution.empty()) {
            return solution;
        }

        // If the first candidate fails, try p[0] = xor_sum_0_to_n_minus_1
        // This is a common trick for problems with cyclic dependencies and XOR sums.
        solution = solve(n, and_vals, xor_sum_0_to_n_minus_1);
        if (!solution.empty()) {
            return solution;
        }

        return {}; // No solution found
    }
};