#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int findChampion(int n, vector<vector<int>>& edges) {
        vector<int> inDegree(n, 0);
        vector<vector<int>> adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            inDegree[v]++;
        }

        unordered_set<int> candidates;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                candidates.insert(i);
            }
        }

        if (candidates.size() != 1) {
            return -1;
        }

        int champion = *candidates.begin();
        vector<bool> visited(n, false);
        int count = 0;

        function<void(int)> dfs = [&](int node) {
            visited[node] = true;
            ++count;
            for (int neighbor : adj[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor);
                }
            }
        };

        dfs(champion);

        return count == n ? champion : -1;
    }
};