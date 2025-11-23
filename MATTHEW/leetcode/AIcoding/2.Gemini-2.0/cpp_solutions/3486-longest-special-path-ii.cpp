#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSpecialPath(int n, vector<int>& lengths, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], lengths[edge[2]]});
            adj[edge[1]].push_back({edge[0], lengths[edge[2]]});
        }

        int max_len = 0;
        vector<int> path;
        vector<bool> visited(n, false);

        function<void(int, int)> dfs = [&](int u, int current_len) {
            visited[u] = true;
            path.push_back(u);
            max_len = max(max_len, current_len);

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int w = neighbor.second;
                if (!visited[v]) {
                    dfs(v, current_len + w);
                }
            }

            visited[u] = false;
            path.pop_back();
        };

        for (int i = 0; i < n; ++i) {
            dfs(i, 0);
            fill(visited.begin(), visited.end(), false);
        }

        return max_len;
    }
};