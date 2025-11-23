#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    int maxResult(std::vector<int>& nums, int k) {
        int n = nums.size();
        // The priority queue stores pairs of (score, index).
        // It's a max-heap, so the top element will always have the maximum score.
        std::priority_queue<std::pair<int, int>> pq;

        // Initialize with the score of the first element at index 0.
        // We will modify nums in-place to store the maximum score to reach each index.
        pq.push({nums[0], 0});

        // Iterate from the second element to the last element.
        for (int i = 1; i < n; ++i) {
            // Remove elements from the priority queue whose indices are outside
            // the current k-sized sliding window [i - k, i - 1].
            while (pq.top().second < i - k) {
                pq.pop();
            }

            // The maximum score to reach the current index i is nums[i]
            // plus the maximum score from any reachable previous index within the k-window.
            // This maximum score is at the top of the priority queue.
            nums[i] += pq.top().first;

            // Add the current index's maximum score to the priority queue.
            pq.push({nums[i], i});
        }

        // The maximum score to reach the last index (n-1) is the answer.
        return nums[n - 1];
    }
};