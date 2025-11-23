#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    long long minMoves(std::vector<int>& nums, int k) {
        std::vector<int> ones_indices;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones_indices.push_back(i);
            }
        }

        // According to typical LeetCode problem constraints and the problem statement
        // "minimum number of operations needed to make k ones consecutive",
        // it is assumed that k is always less than or equal to the total number of ones available.
        // If k were greater than the count of ones, it would be impossible, and the problem
        // would typically specify a return value like -1.
        // For this solution, we proceed assuming ones_indices.size() >= k.

        long long min_span = std::numeric_limits<long long>::max();

        // We use a sliding window approach on the `ones_indices` vector.
        // Each window consists of `k` ones.
        // The loop iterates through all possible starting positions `i` for a window of `k` ones.
        // The window will cover `ones_indices[i]` to `ones_indices[i + k - 1]`.
        for (int i = 0; i <= (int)ones_indices.size() - k; ++i) {
            // `current_span` is the distance between the first and the last '1' in the current window.
            // This is `(last_one_index - first_one_index)`.
            long long current_span = (long long)ones_indices[i + k - 1] - ones_indices[i];
            min_span = std::min(min_span, current_span);
        }

        // The minimum number of moves required to make `k` ones consecutive
        // is `min_span - (k - 1)`.
        // `min_span` represents the minimum total length of the segment that contains the `k` chosen ones.
        // If these `k` ones were already consecutive, the distance between the first and last one would be `k-1`.
        // For example, if `k=3` and ones are at indices `0, 1, 2`, the span is `2-0 = 2`, which is `k-1`.
        // The difference `min_span - (k-1)` represents the number of '0's that are "in between" the chosen `k` ones,
        // which need to be moved out of the way (or '1's moved into those positions) to achieve consecutiveness.
        return min_span - (k - 1);
    }
};