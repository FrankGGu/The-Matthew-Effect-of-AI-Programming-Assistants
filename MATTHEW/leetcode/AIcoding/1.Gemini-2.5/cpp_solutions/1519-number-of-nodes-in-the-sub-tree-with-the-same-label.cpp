#include <vector>
#include <string>
#include <functional>

class Solution {
public:
    std::vector<int> countSubTrees(int n, std::vector<std::vector<int>>& edges, std::string labels) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> ans(n, 0);
        dfs(0, -1, adj, labels, ans);
        return ans;
    }

private:
    std::vector<int> dfs(int node, int parent, const std::vector<std::vector<int>>& adj, const std::string& labels, std::vector<int>& ans) {
        std::vector<int> node_counts(26, 0);
        node_counts[labels[node] - 'a'] = 1;

        for (int child : adj[node]) {
            if (child == parent) {
                continue;
            }
            std::vector<int> child_counts = dfs(child, node, adj, labels, ans);
            for (int i = 0; i < 26; ++i) {
                node_counts[i] += child_counts[i];
            }
        }

        ans[node] = node_counts[labels[node] - 'a'];
        return node_counts;
    }
};