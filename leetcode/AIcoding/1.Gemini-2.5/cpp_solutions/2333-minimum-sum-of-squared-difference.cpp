#include <vector>
#include <numeric>
#include <cmath>
#include <map>
#include <algorithm> // For std::abs

class Solution {
public:
    long long minSumSquareDiff(std::vector<int>& nums1, std::vector<int>& nums2, int k1, int k2) {
        std::map<int, long long> counts;

        for (size_t i = 0; i < nums1.size(); ++i) {
            int diff = std::abs(nums1[i] - nums2[i]);
            if (diff > 0) { // Only store positive differences
                counts[diff]++;
            }
        }

        long long total_k = (long long)k1 + k2;

        // Iterate from largest difference down to 1
        // The map stores counts of each difference value.
        // Example: counts = {100: 3, 50: 2, 10: 1}
        // rbegin() points to (100, 3)
        // std::next(rbegin()) points to (50, 2)

        // Loop continues as long as there are operations left and positive differences exist.
        while (total_k > 0 && !counts.empty()) {
            auto it = counts.rbegin(); // Iterator to the largest difference
            int current_diff_val = it->first;
            long long current_count = it->second;

            if (current_diff_val == 0) { 
                // All remaining differences are zero, no more reductions possible.
                break; 
            }

            // Determine the next largest difference value.
            // If current_diff_val is the only positive difference, next_diff_val will be 0.
            auto next_it = std::next(it);
            int next_diff_val = 0;
            if (next_it != counts.rend()) {
                next_diff_val = next_it->first;
            }

            // Calculate the range of values we can reduce current_diff_val elements by
            // before they reach or pass the next_diff_val.
            long long diff_range = current_diff_val - next_diff_val;

            // Operations needed to reduce all 'current_count' elements by 'diff_range' steps.
            long long ops_needed_for_this_range = current_count * diff_range;

            if (total_k >= ops_needed_for_this_range) {
                // We have enough operations to reduce all 'current_count' elements
                // from current_diff_val down to next_diff_val.
                total_k -= ops_needed_for_this_range;

                // Merge these elements into next_diff_val.
                counts[next_diff_val] += current_count;

                // Erase the current_diff_val entry from the map.
                // Note: Erasing an element invalidates iterators to it.
                // Re-initializing `it` to `counts.rbegin()` is safe here.
                counts.erase(current_diff_val);
                // The loop condition will re-evaluate `it` and `counts.rbegin()` will point to the new largest.
            } else {
                // Not enough operations to reduce all 'current_count' elements to next_diff_val.
                // We will use all remaining 'total_k' operations.

                // How many full steps can each of the 'current_count' elements be reduced?
                long long steps = total_k / current_count;

                // All 'current_count' elements are reduced by 'steps'.
                // Add them to the count for the new difference value.
                counts[current_diff_val - steps] += current_count;
                // Remove the original entry for current_diff_val.
                counts.erase(current_diff_val); 

                // Update remaining operations.
                total_k -= steps * current_count; 

                // Any remaining 'total_k' operations (which will be less than 'current_count')
                // are used to reduce 'total_k' elements by one additional step.
                if (total_k > 0) {
                    counts[current_diff_val - steps - 1] += total_k;
                    // Decrease the count at current_diff_val - steps because 'total_k' elements
                    // were moved one step further down.
                    counts[current_diff_val - steps] -= total_k; 
                }
                total_k = 0; // All operations used
                break;       // Exit loop as k is exhausted
            }
        }

        long long sum_sq_diff = 0;
        for (auto const& [diff_val, count] : counts) {
            // Cast to long long before multiplication to prevent intermediate overflow
            // for diff_val * diff_val.
            sum_sq_diff += (long long)diff_val * diff_val * count;
        }

        return sum_sq_diff;
    }
};