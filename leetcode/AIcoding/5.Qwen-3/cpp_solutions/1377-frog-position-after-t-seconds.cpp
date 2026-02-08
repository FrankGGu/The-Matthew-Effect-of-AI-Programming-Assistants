#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> frogPositionAfterTSeconds(int n, vector<vector<int>>& edges, int t, int target) {
        unordered_map<int, vector<int>> graph;
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n + 1, false);
        queue<pair<int, int>> q;
        q.push({1, 0});
        visited[1] = true;

        while (!q.empty()) {
            auto [node, time] = q.front();
            q.pop();

            if (time == t) {
                return {node};
            }

            bool hasChildren = false;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    hasChildren = true;
                    visited[neighbor] = true;
                    q.push({neighbor, time + 1});
                }
            }

            if (!hasChildren && time < t) {
                return {node};
            }
        }

        return {};
    }
};