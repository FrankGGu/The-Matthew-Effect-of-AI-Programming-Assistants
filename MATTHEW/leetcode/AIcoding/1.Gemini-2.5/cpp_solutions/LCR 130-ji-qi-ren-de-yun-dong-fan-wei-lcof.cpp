#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    // This solution assumes the problem "衣橱整理" (Wardrobe Organization)
    // is a variation of the 0/1 Knapsack problem.
    //
    // 'weights' represents the space or weight each clothing item occupies.
    // 'values' represents the 'value' or 'utility' of each clothing item.
    // 'capacity' is the total space or weight the wardrobe can hold.
    // The goal is to maximize the total value of items placed in the wardrobe
    // without exceeding its capacity.
    int wardrobeOrganization(std::vector<int>& weights, std::vector<int>& values, int capacity) {
        int n = weights.size();

        // dp[j] stores the maximum value that can be obtained with a capacity of 'j'.
        std::vector<int> dp(capacity + 1, 0);

        // Iterate through each item.
        for (int i = 0; i < n; ++i) {
            // Iterate through the capacity from right to left.
            // This ensures that when we consider dp[j - weights[i]],
            // it refers to the state before the current item 'i' was considered,
            // which is crucial for the 0/1 knapsack (each item taken at most once).
            for (int j = capacity; j >= weights[i]; --j) {
                // For the current capacity 'j' and item 'i':
                // We have two choices:
                // 1. Do not include item 'i': The value remains dp[j] (from previous items).
                // 2. Include item 'i': The value is values[i] plus the maximum value
                //    that could be obtained with the remaining capacity (j - weights[i])
                //    using items considered before 'i'.
                dp[j] = std::max(dp[j], dp[j - weights[i]] + values[i]);
            }
        }

        // The maximum value for the full capacity will be stored in dp[capacity].
        return dp[capacity];
    }
};