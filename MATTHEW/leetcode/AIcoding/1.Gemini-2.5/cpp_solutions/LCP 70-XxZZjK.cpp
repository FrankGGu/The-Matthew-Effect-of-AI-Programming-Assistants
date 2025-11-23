#include <string>
#include <vector>
#include <algorithm> // For std::min, std::upper_bound

class Solution {
public:
    int solve(std::string s, int k) {
        int n = s.length();

        // Precompute indices of all existing trees ('1's)
        std::vector<int> ones_indices;
        for (int j = 0; j < n; ++j) {
            if (s[j] == '1') {
                ones_indices.push_back(j);
            }
        }

        int planted_trees = 0;
        int i = 0; // Current position to check for coverage

        while (i < n) {
            // Determine the rightmost position 'j' such that a tree at 'j' can cover 'i'.
            // This position 'j' must be within [i, i + k].
            // We are looking for the rightmost existing tree '1' in this range.
            int search_range_end = std::min(n - 1, i + k);
            int plant_pos_from_existing_tree = -1;

            // Use binary search on ones_indices to find the rightmost '1' in [i, search_range_end]
            // std::upper_bound finds the first element *greater* than search_range_end.
            auto it_upper = std::upper_bound(ones_indices.begin(), ones_indices.end(), search_range_end);

            if (it_upper != ones_indices.begin()) {
                // Move back one element to get the rightmost '1' that is <= search_range_end.
                --it_upper; 
                // Check if this '1' is also within the left bound 'i'.
                if (*it_upper >= i) { 
                    plant_pos_from_existing_tree = *it_upper;
                }
            }

            if (plant_pos_from_existing_tree != -1) {
                // An existing tree at `plant_pos_from_existing_tree` can cover `i`.
                // This tree covers the range `[plant_pos_from_existing_tree - k, plant_pos_from_existing_tree + k]`.
                // Since we chose the rightmost such tree, it covers up to `plant_pos_from_existing_tree + k`.
                // So, the next position to check is `plant_pos_from_existing_tree + k + 1`.
                i = plant_pos_from_existing_tree + k + 1;
            } else {
                // Position `i` is '0' and not covered by any existing '1' in the range `[i, i + k]`.
                // We must plant a new tree.
                // To maximize its future coverage, we plant it as far right as possible while still covering `i`.
                // This optimal position is `i + k`.
                // This new tree covers the range `[i, i + 2*k]`.
                // So, the next position to check is `i + 2*k + 1`.
                planted_trees++;
                i = i + 2 * k + 1;
            }
        }

        return planted_trees;
    }
};