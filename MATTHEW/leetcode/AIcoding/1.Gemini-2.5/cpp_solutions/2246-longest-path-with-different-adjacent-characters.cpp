#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int global_max_path_len;
    std::vector<std::vector<int>> adj;
    std::string s_chars;

    int dfs(int u, int parent) {
        std::vector<int> child_path_lengths;

        for (int v : adj[u]) {
            if (v == parent) {
                continue;
            }
            int child_len = dfs(v, u);
            if (s_chars[u] != s_chars[v]) {
                child_path_lengths.push_back(child_len);
            }
        }

        std::sort(child_path_lengths.rbegin(), child_path_lengths.rend());

        int max1 = 0, max2 = 0;
        if (!child_path_lengths.empty()) {
            max1 = child_path_lengths[0];
        }
        if (child_path_lengths.size() >= 2) {
            max2 = child_path_lengths[1];
        }

        global_max_path_len = std::max(global_max_path_len, 1 + max1 + max2);

        return 1 + max1;
    }

    int longestPath(std::vector<int>& parent, std::string s) {
        int n = parent.size();
        adj.resize(n);
        s_chars = s;

        for (int i = 1; i < n; ++i) {
            adj[parent[i]].push_back(i);
            adj[i].push_back(parent[i]);
        }

        global_max_path_len = 1;

        dfs(0, -1);

        return global_max_path_len;
    }
};