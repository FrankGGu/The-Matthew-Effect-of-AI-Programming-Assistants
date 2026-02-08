#include <vector>
#include <algorithm>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> minInterval(std::vector<std::vector<int>>& intervals, std::vector<int>& queries) {
        // Store queries with their original indices to reconstruct the result in the correct order.
        std::vector<std::pair<int, int>> sorted_queries(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            sorted_queries[i] = {queries[i], i};
        }

        // Sort queries by their value in ascending order.
        std::sort(sorted_queries.begin(), sorted_queries.end());

        // Sort intervals by their start point (li) in ascending order.
        std::sort(intervals.begin(), intervals.end());

        // Initialize the answer vector.
        std::vector<int> ans(queries.size());

        // Min-priority queue to store (interval_length, end_point).
        // It will be ordered by interval_length (smallest length at the top).
        // std::greater<std::pair<int, int>> makes it a min-heap for pairs,
        // comparing first by the first element, then by the second.
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> min_heap;

        int interval_idx = 0; // Pointer to keep track of intervals that have not yet been considered.

        // Process each query in sorted order.
        for (const auto& q_pair : sorted_queries) {
            int q_val = q_pair.first;
            int original_idx = q_pair.second;

            // 1. Add intervals whose start point (li) is less than or equal to the current query value (q_val).
            // These intervals are now potential candidates for the current and future queries.
            while (interval_idx < intervals.size() && intervals[interval_idx][0] <= q_val) {
                int l = intervals[interval_idx][0];
                int r = intervals[interval_idx][1];
                min_heap.push({r - l + 1, r}); // Push (length, end_point)
                interval_idx++;
            }

            // 2. Remove intervals from the min_heap whose end point (ri) is less than the current query value (q_val).
            // These intervals no longer cover the current query or any subsequent queries.
            while (!min_heap.empty() && min_heap.top().second < q_val) {
                min_heap.pop();
            }

            // 3. After adding relevant intervals and removing irrelevant ones,
            // the top of the min_heap contains the minimum length interval
            // that includes the current query value (if any such interval exists).
            if (!min_heap.empty()) {
                ans[original_idx] = min_heap.top().first;
            } else {
                // If the heap is empty, no interval covers the current query.
                ans[original_idx] = -1;
            }
        }

        return ans;
    }
};