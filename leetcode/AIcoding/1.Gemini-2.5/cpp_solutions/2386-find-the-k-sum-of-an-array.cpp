#include <vector>
#include <numeric>
#include <algorithm>
#include <queue>
#include <cmath> // For std::abs

class Solution {
public:
    long long kSum(std::vector<int>& nums, int k) {
        long long S_max = 0;
        std::vector<long long> diffs;
        for (int x : nums) {
            S_max += std::abs(x);
            diffs.push_back(std::abs(x));
        }

        std::sort(diffs.begin(), diffs.end());

        int n = diffs.size();

        // Min-priority queue to store pairs of (current_sum, last_element_index)
        // current_sum: sum of elements in the current subset
        // last_element_index: index of the largest element from 'diffs' that is included in 'current_sum'
        // If current_sum is 0 (empty set), last_element_index is -1.
        std::priority_queue<std::pair<long long, int>, 
                            std::vector<std::pair<long long, int>>, 
                            std::greater<std::pair<long long, int>>> pq;

        pq.push({0, -1}); // Initial state: sum 0, no elements included yet

        std::vector<long long> k_smallest_subset_sums;
        while (k_smallest_subset_sums.size() < k && !pq.empty()) {
            auto [current_sum, last_idx] = pq.top();
            pq.pop();
            k_smallest_subset_sums.push_back(current_sum);

            // Option 1: Add the next available element (diffs[last_idx + 1]) to the current sum.
            // This forms a new subset sum by extending the current subset.
            // Example: if current_sum is {d_a, d_b} and last_idx is b, we add d_{b+1} to get {d_a, d_b, d_{b+1}}.
            // If current_sum is 0 and last_idx is -1, we add d_0 to get {d_0}.
            if (last_idx + 1 < n) {
                pq.push({current_sum + diffs[last_idx + 1], last_idx + 1});
            }

            // Option 2: If current_sum was formed by including diffs[last_idx],
            // replace diffs[last_idx] with the next available element (diffs[last_idx + 1]).
            // This forms a new subset sum by changing one element in the current subset.
            // Example: if current_sum is {d_a, d_b} and last_idx is b, we replace d_b with d_{b+1} to get {d_a, d_{b+1}}.
            // This is only valid if last_idx >= 0 (i.e., current_sum is not 0)
            // AND last_idx + 1 < n (i.e., there is a next element to replace with).
            if (last_idx >= 0 && last_idx + 1 < n) {
                pq.push({current_sum - diffs[last_idx] + diffs[last_idx + 1], last_idx + 1});
            }
        }

        // The k-th largest sum is S_max minus the (k-1)-th smallest difference sum.
        // The differences are 2 * diffs[i], but since we started with S_max = sum(abs(x)),
        // any reduction by 'diffs[i]' effectively means we're not flipping that 'abs(x)' to '-abs(x)'.
        // So the actual reduction from S_max is 2 * (sum of subset of abs(x)).
        // The k_smallest_subset_sums vector stores these 'sum of subset of abs(x)' values.
        return S_max - k_smallest_subset_sums[k - 1];
    }
};