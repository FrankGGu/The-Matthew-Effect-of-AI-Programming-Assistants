#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> minEdgeReversals(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], 0});
            adj[edge[1]].push_back({edge[0], 1});
        }

        vector<int> ans(n);

        function<int(int, int)> dfs = [&](int u, int start) {
            int count = 0;
            vector<bool> visited(n, false);
            queue<int> q;
            q.push(start);
            visited[start] = true;

            while (!q.empty()) {
                int curr = q.front();
                q.pop();

                for (auto& neighbor : adj[curr]) {
                    if (!visited[neighbor.first]) {
                        visited[neighbor.first] = true;
                        q.push(neighbor.first);
                        if (neighbor.second == 1) {
                            count++;
                        }
                    }
                }
            }
            return count;
        };

        for (int i = 0; i < n; ++i) {
            ans[i] = dfs(n, i);
        }

        return ans;
    }
};