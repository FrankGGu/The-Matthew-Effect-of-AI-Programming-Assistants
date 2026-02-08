#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> nums_;

    // DFS function to check if a subtree can form components with the given target_sum.
    // Returns:
    // - -1 if it's impossible to form components with target_sum within this subtree.
    // - 0 if this subtree successfully forms a component (or multiple components)
    //   and the current node's part of the component has been "cut off".
    // - A positive value (less than target_sum) if this subtree's sum is part of
    //   a larger component that needs to be formed with its parent.
    long long dfs(int u, int p, long long target_sum) {
        long long current_subtree_sum = nums_[u];

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            long long child_subtree_sum = dfs(v, u, target_sum);
            if (child_subtree_sum == -1) { // Impossible path found in child's subtree
                return -1;
            }
            current_subtree_sum += child_subtree_sum;
        }

        if (current_subtree_sum > target_sum) {
            return -1; // Current subtree sum exceeds target, impossible
        }
        if (current_subtree_sum == target_sum) {
            return 0; // This subtree forms a valid component, cut it off
        }
        return current_subtree_sum; // This subtree needs to be part of a larger component
    }

    int componentValue(std::vector<int>& nums, std::vector<std::vector<int>>& edges) {
        int n = nums.size();
        adj.resize(n);
        nums_ = nums; // Copy values to member variable

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        long long total_sum = 0;
        for (int val : nums) {
            total_sum += val;
        }

        std::vector<long long> divisors;
        for (long long i = 1; i * i <= total_sum; ++i) {
            if (total_sum % i == 0) {
                divisors.push_back(i);
                if (i * i != total_sum) {
                    divisors.push_back(total_sum / i);
                }
            }
        }
        std::sort(divisors.begin(), divisors.end()); // Sort in ascending order

        // We want to maximize k (number of components).
        // k = total_sum / s, where s is the sum of each component.
        // To maximize k, we need to find the smallest possible s for which a valid partition exists.
        for (long long s : divisors) {
            // Check if it's possible to partition the tree into components, each with sum 's'.
            // The DFS should return 0 if the entire tree (after forming all possible components)
            // also forms a valid component of sum 's'.
            if (dfs(0, -1, s) == 0) {
                // If a valid 's' is found, total_sum / s is the number of components.
                // Since divisors are sorted, this 's' is the smallest possible target sum,
                // which means total_sum / s will be the largest possible k.
                return total_sum / s;
            }
        }

        // This line should theoretically not be reached because total_sum itself is always a valid
        // component sum (the entire tree is one component), and total_sum is always in divisors.
        // So, at least for s = total_sum, dfs will return 0.
        return 1; // Fallback, implies the whole tree is one component.
    }
};