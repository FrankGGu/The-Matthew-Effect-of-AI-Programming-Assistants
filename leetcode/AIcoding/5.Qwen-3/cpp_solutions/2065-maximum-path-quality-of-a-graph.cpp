#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int maxPathQuality(int n, vector<vector<int>>& edges, vector<int>& isVisited, int s, int t) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back({edge[1], edge[2]});
            graph[edge[1]].push_back({edge[0], edge[2]});
        }

        vector<int> visited(n, 0);
        int result = 0;
        queue<pair<int, int>> q;
        q.push({s, 0});
        visited[s] = 1;

        while (!q.empty()) {
            auto [node, cost] = q.front();
            q.pop();

            if (node == t) {
                result = max(result, cost);
            }

            for (auto& [neighbor, weight] : graph[node]) {
                if (visited[neighbor] == 0) {
                    visited[neighbor] = 1;
                    q.push({neighbor, cost + weight});
                }
            }
        }

        return result;
    }
};