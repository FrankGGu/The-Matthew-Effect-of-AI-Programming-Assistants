#include <vector>
#include <queue>
#include <set>
#include <algorithm> // For std::max, std::min

class Solution {
public:
    std::vector<int> minimumReverseOperations(int n, int p, std::vector<int>& banned, int k) {
        std::vector<int> ans(n, -1);
        std::set<int> available_indices;

        for (int i = 0; i < n; ++i) {
            available_indices.insert(i);
        }

        for (int b_idx : banned) {
            available_indices.erase(b_idx);
        }

        // According to problem constraints, p is not in banned.
        // If p was banned, it would be impossible to start.
        // available_indices.find(p) should always succeed here.

        std::queue<int> q;

        ans[p] = 0;
        q.push(p);
        available_indices.erase(p); // Mark p as visited by removing it from available_indices

        while (!q.empty()) {
            int curr_idx = q.front();
            q.pop();
            int current_dist = ans[curr_idx];

            // Calculate the range of 'i' (start of subarray) for the reverse operation
            // such that curr_idx is within [i, i + k - 1].
            // This means:
            // 1. i <= curr_idx
            // 2. curr_idx <= i + k - 1  =>  i >= curr_idx - k + 1
            // 3. 0 <= i (subarray starts at or after 0)
            // 4. i + k - 1 < n  =>  i <= n - k (subarray ends before n)

            int L = std::max(0, curr_idx - k + 1);
            int R = std::min(n - k, curr_idx);

            // The new position x' after reversing subarray [i, i+k-1] when current position is curr_idx is:
            // x' = i + ( (i + k - 1) - curr_idx ) = 2*i + k - 1 - curr_idx
            // Since x' is an increasing function of i, we can find the minimum and maximum possible x'
            // by using L and R respectively.
            int target_min = 2 * L + k - 1 - curr_idx;
            int target_max = 2 * R + k - 1 - curr_idx;

            // Iterate through available_indices to find unvisited nodes in the calculated range [target_min, target_max].
            // Use lower_bound to find the first element >= target_min.
            auto it = available_indices.lower_bound(target_min);
            while (it != available_indices.end() && *it <= target_max) {
                int next_idx = *it;
                ans[next_idx] = current_dist + 1;
                q.push(next_idx);
                // Erase the element and get an iterator to the next element.
                // This efficiently removes visited nodes and continues iteration.
                it = available_indices.erase(it); 
            }
        }

        return ans;
    }
};