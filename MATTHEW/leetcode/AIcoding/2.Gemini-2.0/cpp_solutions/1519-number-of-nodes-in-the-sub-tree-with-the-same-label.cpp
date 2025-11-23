#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> countSubTrees(int n, vector<vector<int>>& edges, string labels) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> result(n, 0);
        vector<bool> visited(n, false);

        function<vector<int>(int)> dfs = [&](int node) {
            visited[node] = true;
            vector<int> counts(26, 0);
            counts[labels[node] - 'a'] = 1;

            for (int neighbor : adj[node]) {
                if (!visited[neighbor]) {
                    vector<int> neighborCounts = dfs(neighbor);
                    for (int i = 0; i < 26; ++i) {
                        counts[i] += neighborCounts[i];
                    }
                }
            }

            result[node] = counts[labels[node] - 'a'];
            return counts;
        };

        dfs(0);
        return result;
    }
};