#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countPairs(int n, vector<vector<int>>& edges, vector<int>& signalSpeed) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            adj[u].push_back({v, w});
            adj[v].push_back({u, w});
        }

        vector<int> result(n, 0);
        for (int i = 0; i < n; ++i) {
            vector<int> counts;
            for (auto& neighbor : adj[i]) {
                int target = neighbor.first;
                int weight = neighbor.second;
                int speed = signalSpeed[i];
                counts.push_back(dfs(target, i, adj, weight, speed));
            }

            for (int j = 0; j < counts.size(); ++j) {
                for (int k = j + 1; k < counts.size(); ++k) {
                    result[i] += counts[j] * counts[k];
                }
            }
        }

        return result;
    }

private:
    int dfs(int node, int parent, vector<vector<pair<int, int>>>& adj, int current_weight, int speed) {
        if (current_weight % speed == 0) {
            int count = 1;
            for (auto& neighbor : adj[node]) {
                if (neighbor.first != parent) {
                    count += dfs(neighbor.first, node, adj, neighbor.second, speed);
                }
            }
            return count;
        } else {
            return 0;
        }
    }
};