#include <vector>
#include <numeric>

class Solution {
public:
    int dfs(int u, const std::vector<std::vector<int>>& adj, std::vector<int>& totalReports) {
        if (totalReports[u] != -1) {
            return totalReports[u];
        }

        int current_reports = 0;
        for (int v : adj[u]) {
            current_reports += (1 + dfs(v, adj, totalReports));
        }
        totalReports[u] = current_reports;
        return current_reports;
    }

    std::vector<int> analyzeHierarchy(int n, const std::vector<int>& manager) {
        std::vector<std::vector<int>> adj(n);
        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                adj[manager[i]].push_back(i);
            }
        }

        std::vector<int> totalReports(n, -1);

        for (int i = 0; i < n; ++i) {
            dfs(i, adj, totalReports);
        }

        return totalReports;
    }
};