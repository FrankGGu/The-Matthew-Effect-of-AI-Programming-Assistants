#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxAndSum(std::vector<int>& nums, int numSlots) {
        int N = nums.size();
        int M = numSlots;

        // dp[mask] stores the maximum AND sum for the given slot configuration 'mask'.
        // Each slot 'j' (0 to M-1) uses two bits in the mask:
        // bits (2*j) and (2*j+1) represent slot j's state:
        // 00 (0): empty
        // 01 (1): one number placed
        // 10 (2): two numbers placed (full)
        // State 11 (3) is invalid/unreachable due to the transitions.
        int max_mask = 1 << (2 * M);
        std::vector<int> dp(max_mask, -1); // Use -1 to represent unreachable states

        dp[0] = 0; // Base case: 0 sum for empty slots

        int final_max_sum = 0;

        // Iterate through all possible slot configurations (masks)
        for (int mask = 0; mask < max_mask; ++mask) {
            if (dp[mask] == -1) { // If this mask is unreachable, skip
                continue;
            }

            // Calculate 'k', the number of elements placed so far for this mask.
            // This 'k' also indicates which number from 'nums' (nums[k]) is next to be placed.
            int k = 0;
            for (int j = 0; j < M; ++j) {
                int state = (mask >> (2 * j)) & 3; // Get the two bits representing slot j's state
                if (state == 1) { // 01: one number placed
                    k++;
                } else if (state == 2) { // 10: two numbers placed (full)
                    k += 2;
                }
            }

            if (k == N) { // All numbers from 'nums' have been placed
                final_max_sum = std::max(final_max_sum, dp[mask]);
                continue; // No more numbers to place for this mask
            }

            // Try to place nums[k] (the next number to be placed) into an available slot
            int current_num = nums[k];

            for (int slot_idx = 0; slot_idx < M; ++slot_idx) {
                int slot_state = (mask >> (2 * slot_idx)) & 3;

                if (slot_state == 0) { // Slot is empty (00)
                    // Place current_num as the first number in this slot
                    // New state for slot_idx: 01 (1)
                    int new_mask = mask | (1 << (2 * slot_idx));
                    dp[new_mask] = std::max(dp[new_mask], dp[mask] + (current_num & (slot_idx + 1)));
                } else if (slot_state == 1) { // Slot has one number (01)
                    // Place current_num as the second number in this slot
                    // New state for slot_idx: 10 (2)
                    // To change 01 to 10: clear bit (2*slot_idx), set bit (2*slot_idx + 1)
                    int new_mask = (mask & ~(1 << (2 * slot_idx))) | (1 << (2 * slot_idx + 1));
                    dp[new_mask] = std::max(dp[new_mask], dp[mask] + (current_num & (slot_idx + 1)));
                }
                // If slot_state == 2 (full), we cannot place current_num here, so do nothing.
            }
        }

        // The problem guarantees N <= 2 * numSlots, so all numbers can always be placed.
        // The final_max_sum will be correctly updated by the loop.
        return final_max_sum;
    }
};