#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximizeTheNumberOfTargetNodes(vector<int>& target, vector<vector<int>>& edges) {
        int n = target.size();
        unordered_set<int> targetSet(target.begin(), target.end());
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int ans = 0;

        function<pair<bool, bool>(int)> dfs = [&](int u) {
            visited[u] = true;
            bool hasTarget = targetSet.count(u) > 0;
            bool canConnect = false;

            for (int v : adj[u]) {
                if (!visited[v]) {
                    auto childResult = dfs(v);
                    if (childResult.first) {
                        canConnect = true;
                    }
                    hasTarget |= childResult.second;
                }
            }

            if (hasTarget && canConnect) {
                ans++;
                return {false, false};
            } else if (hasTarget) {
                return {true, false};
            } else {
                return {false, false};
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i);
            }
        }

        return ans;
    }
};