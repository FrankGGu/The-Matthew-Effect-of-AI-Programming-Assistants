#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> countSubTrees(int n, string& edges, string& labels) {
        vector<vector<int>> adj(n);
        for (int i = 0; i < edges.length(); i += 2) {
            int u = edges[i] - '0';
            int v = edges[i + 1] - '0';
            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        vector<int> result(n, 0);
        vector<bool> visited(n, false);

        function<vector<int>(int)> dfs = [&](int node) -> vector<int> {
            visited[node] = true;
            vector<int> count(26, 0);
            count[labels[node] - 'a'] = 1;

            for (int neighbor : adj[node]) {
                if (!visited[neighbor]) {
                    vector<int> childCount = dfs(neighbor);
                    for (int i = 0; i < 26; ++i) {
                        count[i] += childCount[i];
                    }
                }
            }

            result[node] = count[labels[node] - 'a'];
            return count;
        };

        dfs(0);
        return result;
    }
};