#include <vector>
#include <algorithm>

class Solution {
public:
    int dfs(int u, int current_accumulated_time, const std::vector<std::vector<int>>& adj, const std::vector<int>& informTime) {
        int max_time_in_subtree = current_accumulated_time;

        for (int v : adj[u]) {
            max_time_in_subtree = std::max(max_time_in_subtree, dfs(v, current_accumulated_time + informTime[u], adj, informTime));
        }

        return max_time_in_subtree;
    }

    int numOfMinutes(int n, int headID, std::vector<int>& manager, std::vector<int>& informTime) {
        std::vector<std::vector<int>> adj(n);

        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                adj[manager[i]].push_back(i);
            }
        }

        return dfs(headID, 0, adj, informTime);
    }
};