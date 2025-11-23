#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int B; // Stores batchSize for easy access in recursive function

    // memo_dp[current_remainder] stores a map from counts_vector to max_groups.
    // current_remainder ranges from 0 to B-1. Max B is 9, so array size 9.
    // The counts_vector stores counts for remainders 1 to B-1.
    // counts[0] corresponds to original_remainder 1, counts[1] to original_remainder 2, etc.
    // counts[i] corresponds to original_remainder (i+1).
    std::map<std::vector<int>, int> memo_dp[9]; 

    // Recursive DP function
    // current_remainder: The remainder of the sum of people in the current group being formed.
    // counts: A vector storing the counts of groups for remainders 1 to B-1.
    //         counts[i] is the number of groups with (original_remainder = i+1) remaining.
    int solve_dp(int current_remainder, std::vector<int>& counts) {
        // Check if all groups have been used (all counts are zero)
        bool all_zero = true;
        for (int c : counts) {
            if (c > 0) {
                all_zero = false;
                break;
            }
        }
        if (all_zero) {
            return 0; // No more groups, no more fresh donuts
        }

        // Check memoization table
        if (memo_dp[current_remainder].count(counts)) {
            return memo_dp[current_remainder][counts];
        }

        int max_additional_groups = 0;

        // Iterate through each possible group type (remainder 1 to B-1)
        // to add to the current batch.
        for (int i = 0; i < B - 1; ++i) { 
            if (counts[i] > 0) { // If there are groups of this type available
                counts[i]--; // Use one group of type (i+1)

                int original_remainder_val = i + 1; // The actual remainder value (1 to B-1)
                int next_remainder = (current_remainder + original_remainder_val) % B;
                int current_groups_from_this_path = 0;

                if (next_remainder == 0) {
                    // If adding this group makes the total sum a multiple of B,
                    // this group gets fresh donuts. Increment count by 1.
                    // Then, reset the current_remainder to 0 for the next group.
                    current_groups_from_this_path = 1 + solve_dp(0, counts);
                } else {
                    // If not a multiple, continue forming the current group
                    // with the new remainder.
                    current_groups_from_this_path = solve_dp(next_remainder, counts);
                }

                // Update the maximum number of groups found so far
                max_additional_groups = std::max(max_additional_groups, current_groups_from_this_path);

                counts[i]++; // Backtrack: restore the count for the next iteration
            }
        }

        // Store and return the result for the current state
        return memo_dp[current_remainder][counts] = max_additional_groups;
    }

    // Main function to solve the problem
    int maxHappyGroups(int batchSize, std::vector<int>& groups) {
        B = batchSize; // Store batchSize in member variable

        // Initialize counts for each remainder (0 to B-1)
        std::vector<int> initial_counts(B, 0); 
        int fresh_donuts_from_zero_remainder = 0;

        // Process initial groups:
        // Groups with remainder 0 always get fresh donuts immediately.
        // Other groups contribute to initial_counts.
        for (int g : groups) {
            if (g % B == 0) {
                fresh_donuts_from_zero_remainder++;
            } else {
                initial_counts[g % B]++;
            }
        }

        // Prepare the counts vector for the DP function.
        // It only needs to store counts for remainders 1 to B-1.
        std::vector<int> dp_counts(B - 1);
        for (int i = 1; i < B; ++i) {
            dp_counts[i - 1] = initial_counts[i];
        }

        // Clear the memoization table for each test case.
        // This is crucial for LeetCode where Solution object might be reused.
        for (int i = 0; i < B; ++i) {
            memo_dp[i].clear();
        }

        // Start the DP recursion.
        // Initial state: current_remainder = 0 (empty batch), using dp_counts.
        // Add the groups that already got fresh donuts (remainder 0 groups).
        return fresh_donuts_from_zero_remainder + solve_dp(0, dp_counts);
    }
};