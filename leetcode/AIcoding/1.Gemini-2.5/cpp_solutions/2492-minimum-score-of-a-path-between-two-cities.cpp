#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int minScore(int n, std::vector<std::vector<int>>& roads) {
        std::vector<std::vector<std::pair<int, int>>> adj(n + 1);
        for (const auto& road : roads) {
            int u = road[0];
            int v = road[1];
            int dist = road[2];
            adj[u].push_back({v, dist});
            adj[v].push_back({u, dist});
        }

        std::vector<bool> visited(n + 1, false);
        std::queue<int> q;

        q.push(1);
        visited[1] = true;

        int min_overall_score = 1000000001; 

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int dist = edge.second;

                min_overall_score = std::min(min_overall_score, dist);

                if (!visited[v]) {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return min_overall_score;
    }
};