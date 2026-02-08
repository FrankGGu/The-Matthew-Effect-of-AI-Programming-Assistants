#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximalPathQuality(vector<int>& values, vector<vector<int>>& edges, int maxTime) {
        int n = values.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        int maxQuality = 0;
        vector<int> visited(n, 0);
        visited[0] = 1;

        function<void(int, int, int)> dfs = [&](int node, int currentTime, int currentQuality) {
            if (node == 0) {
                maxQuality = max(maxQuality, currentQuality);
            }

            for (auto& neighbor : adj[node]) {
                int nextNode = neighbor.first;
                int timeTaken = neighbor.second;

                if (currentTime + timeTaken <= maxTime) {
                    if (visited[nextNode] == 0) {
                        visited[nextNode] = 1;
                        dfs(nextNode, currentTime + timeTaken, currentQuality + values[nextNode]);
                        visited[nextNode] = 0;
                    } else {
                        dfs(nextNode, currentTime + timeTaken, currentQuality);
                    }
                }
            }
        };

        dfs(0, 0, values[0]);
        return maxQuality;
    }
};