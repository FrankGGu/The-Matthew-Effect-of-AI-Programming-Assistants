#include <vector>
#include <algorithm>

class Solution {
public:
    int maxEnvelopes(std::vector<std::vector<int>>& envelopes) {
        if (envelopes.empty()) {
            return 0;
        }

        // Sort envelopes:
        // 1. Sort by width (w) in ascending order.
        // 2. If widths are equal, sort by height (h) in descending order.
        // This specific sorting strategy is crucial. When widths are equal,
        // sorting heights in descending order ensures that for envelopes with the same width,
        // only one of them can be part of the LIS on heights. For example,
        // if we have (3,5) and (3,4), sorting as (3,5), (3,4) means that when we process
        // heights, 4 will not be considered "greater" than 5, thus preventing
        // an invalid sequence like (..., (3,5)) -> (3,4).
        std::sort(envelopes.begin(), envelopes.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] < b[0];
            }
            return a[1] > b[1];
        });

        // Extract heights to apply the Longest Increasing Subsequence (LIS) algorithm
        std::vector<int> heights;
        for (const auto& env : envelopes) {
            heights.push_back(env[1]);
        }

        // Find the Longest Increasing Subsequence (LIS) of heights
        // This uses a patience sorting-like approach with a 'tails' array.
        // 'tails[i]' stores the smallest tail of all increasing subsequences of length 'i+1'.
        std::vector<int> tails; 

        for (int height : heights) {
            // Use std::upper_bound to find the first element in 'tails' that is strictly greater than 'height'.
            // This is for finding a strictly increasing subsequence.
            auto it = std::upper_bound(tails.begin(), tails.end(), height);

            if (it == tails.end()) {
                // If 'height' is greater than all elements currently in 'tails',
                // it means we can extend the longest increasing subsequence found so far.
                tails.push_back(height);
            } else {
                // Otherwise, 'height' can replace the element pointed to by 'it'.
                // This creates an increasing subsequence of the same length but ending
                // with a smaller value ('height'), which is more favorable for future extensions.
                *it = height;
            }
        }

        // The size of 'tails' vector represents the length of the LIS,
        // which corresponds to the maximum number of Russian doll envelopes.
        return tails.size();
    }
};