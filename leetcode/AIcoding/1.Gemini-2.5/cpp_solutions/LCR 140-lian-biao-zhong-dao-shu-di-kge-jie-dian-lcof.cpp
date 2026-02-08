#include <vector>
#include <numeric>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    int minimumTime(std::vector<int>& nums1, std::vector<int>& nums2, int x) {
        int n = nums1.size();

        // Calculate the total sum of nums2 elements.
        // This will be used in the formula for the total sum of remaining elements.
        long long S_total_nums2 = 0;
        for (int val : nums2) {
            S_total_nums2 += val;
        }

        // Create pairs of (nums1[i], nums2[i]).
        // Sorting these pairs is not strictly necessary for this O(N^2 log N) approach,
        // but it's a common step in related DP solutions and doesn't hurt here.
        // For this specific derivation, we sort the 'transformed_values' in each iteration.
        std::vector<std::pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums1[i], nums2[i]};
        }

        // Iterate through all possible counts of elements to keep, 'j',
        // from 'n' (keep all, 0 operations) down to '0' (keep none, 'n' operations).
        // We are looking for the largest 'j' that satisfies the condition,
        // as this corresponds to the minimum number of operations (n - j).
        for (int j = n; j >= 0; --j) {
            // For a fixed number of kept items 'j', the total sum of remaining elements is:
            // sum(nums1[k] for k in K) + (sum(nums2[r] for r in R)) * j
            // where K is the set of 'j' kept indices and R is the set of 'n-j' removed indices.
            // This can be rewritten as:
            // S_total_nums2 * j + sum(nums1[k] - nums2[k] * j for k in K)
            // To minimize this total sum for a fixed 'j', we need to choose 'j' items
            // such that sum(nums1[k] - nums2[k] * j) is minimized.

            // Calculate these 'transformed_values' for the current 'j'.
            std::vector<long long> transformed_values;
            transformed_values.reserve(n);
            for (int i = 0; i < n; ++i) {
                transformed_values.push_back((long long)pairs[i].first - (long long)pairs[i].second * j);
            }

            // Sort the transformed values to easily pick the 'j' smallest ones.
            std::sort(transformed_values.begin(), transformed_values.end());

            // Sum the 'j' smallest transformed values.
            long long current_min_sum_val = 0;
            for (int p = 0; p < j; ++p) {
                current_min_sum_val += transformed_values[p];
            }

            // Calculate the total sum for the current 'j'.
            long long total_current_sum = S_total_nums2 * j + current_min_sum_val;

            // If the condition is met, we have found the largest 'j' (and thus minimum 'n-j').
            if (total_current_sum <= x) {
                return n - j;
            }
        }

        // This line should theoretically not be reached based on typical LeetCode problem guarantees
        // (i.e., a solution always exists). If it is reached, it implies that even removing all 'n' items
        // (which results in a sum of 0) does not satisfy the condition '0 <= x' (meaning x is negative).
        // In such a case, returning 'n' would imply it's impossible to meet the condition.
        // However, for LeetCode 2809, a valid minimum number of operations is always found.
        return n; 
    }
};