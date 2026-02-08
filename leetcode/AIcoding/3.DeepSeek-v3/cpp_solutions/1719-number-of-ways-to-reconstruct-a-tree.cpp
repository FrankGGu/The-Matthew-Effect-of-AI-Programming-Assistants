#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int checkWays(vector<vector<int>>& pairs) {
        unordered_map<int, unordered_set<int>> adj;
        for (auto& p : pairs) {
            adj[p[0]].insert(p[1]);
            adj[p[1]].insert(p[0]);
        }

        int n = adj.size();
        vector<int> nodes;
        for (auto& [node, neighbors] : adj) {
            nodes.push_back(node);
        }

        sort(nodes.begin(), nodes.end(), [&](int a, int b) {
            return adj[a].size() > adj[b].size();
        });

        if (adj[nodes[0]].size() != n - 1) {
            return 0;
        }

        bool multiple = false;
        for (int i = 1; i < nodes.size(); ++i) {
            int u = nodes[i];
            int parent = -1;
            for (int j = 0; j < i; ++j) {
                int v = nodes[j];
                if (adj[u].count(v)) {
                    parent = v;
                    break;
                }
            }
            if (parent == -1) {
                return 0;
            }
            for (int neighbor : adj[u]) {
                if (neighbor != parent && !adj[parent].count(neighbor)) {
                    return 0;
                }
            }
            if (adj[u].size() == adj[parent].size()) {
                multiple = true;
            }
        }
        return multiple ? 2 : 1;
    }
};